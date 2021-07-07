import { Component, OnInit } from '@angular/core';
import { AuthService } from '../services/auth/auth.service';
import { DashboardService } from '../services/dashboard/dashboard.service';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { Observable, Subscriber } from 'rxjs';
import { Router } from '@angular/router';

import Swal from 'sweetalert2';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  obras: any = [];
  visitas: number = 0;

  error: boolean = false;
  currentUser: any = '';
  infoUser: any = '';
  showModal: boolean = false;
  submitted = false;
  imgBase64: string = '';

  publicacionForm = new FormGroup({
    _Id: new FormControl(''),
    nombreObra: new FormControl('', Validators.required),
    descripcionObra: new FormControl('', Validators.required),
    ubicacion: new FormControl('', Validators.required),
    imgObra: new FormControl('', Validators.required)    
  });

  constructor( private auth: AuthService, private dashService: DashboardService, private route: Router ) { }

  ngOnInit(): void 
  {
    this.getUser();       
  }

  submitPublicacion()
  {    
    this.submitted = true;    
    this.publicacionForm.controls['imgObra'].setValue( this.imgBase64 );
    this.publicacionForm.controls['_Id'].setValue( this.auth.getId() );

    if (this.publicacionForm.invalid) 
    {
      this.submitted = false;
      return;
    }
    
    Swal.fire({
      title: '¿Estas seguro?',
      text: "¿Realmente quieres publicar esta obra?",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Si, hazlo!',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {        

        this.dashService.nuevaPublicacion( this.publicacionForm.value )
        .then( e => 
          {
            if (e.status == 200) 
            {
              this.showModal = false;
              this.publicacionForm.reset();
             
              Swal.fire({
                position: 'top-end',
                icon: 'success',
                title: 'Publicado correctamente!',
                showConfirmButton: false,
                timer: 1500
              });
    
            }
            //console.log(e);
          });
      
      }
    })
    
  }

  imagenError(event: any) 
  {    
    event.target.src = '../../assets/default-img.png';
  }

  getUser()
  {
    this.getInfoUser();
    this.getObras();
  }

  getObras()
  {
    this.dashService.getObrasArtista()
    .then( e => { 
      //console.log(e)
      if ( e.status == 200 ) 
      {        
        this.obras.push(...e.message.obras);
        this.visitas = e.message.visitas != null ? e.message.visitas.visitas : 0
      }
      
    });
  }

  getInfoUser()
  {
    this.dashService.getInfoArtista()
    .then( e => 
      {       
        console.log(e)
        this.currentUser = this.auth.getUser(); 
        const { status, message } = e;

        if (status == 0) 
        {
          this.error = true;
          return;
        }

        if (status == 200) 
        {
          this.infoUser = message;
         // console.log(this.infoUser);  
         this.error = false;
        }
        else if(status == 401)
        {
          this.route.navigate(['/']);
          this.auth.logOut();
        }
      })
    .catch( e => console.log(e) )
  }

  show()
  {    
    this.showModal = true;
    //console.log("e")
  }

  hide()
  {
    this.showModal = false;    
    this.publicacionForm.reset();
  }

  onChange( $event: Event ){

    let d: any = ($event.target as HTMLInputElement).files;

    for (let i = 0; i < d.length; i++) 
    {
      const file = d[i];
      this.convertBase64(file);       
    }
   
  }

  convertBase64( file: File ){
    const observable = new Observable( (subscriber: Subscriber<any>) => {
      this.readFile( file, subscriber );
    });

    observable.subscribe( (d)=> {    
      this.imgBase64 = d;
      //console.log(d);
    });

  }

  readFile( file: File, subscriber: Subscriber<any> ){
    const filereader = new FileReader();
    filereader.readAsDataURL(file);

    filereader.onload = () => {      
      subscriber.next(filereader.result);
      subscriber.complete();
    }

    filereader.onerror = (err) => {
      subscriber.error(err);
      subscriber.complete();
    }

  }


}
