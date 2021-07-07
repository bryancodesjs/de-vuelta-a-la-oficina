import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ActualizarObraPendiente } from '../../models';
import Swal from 'sweetalert2'
import { BackofficeService } from 'src/app/services/backoffice/backoffice.service';

@Component({
  selector: 'app-publicaciones',
  templateUrl: './publicaciones.component.html',
  styleUrls: ['./publicaciones.component.scss']
})
export class PublicacionesComponent implements OnInit {

  obrasPendientes: any = [];

  body: ActualizarObraPendiente = {
    id: '',
    accion: ''
  } 

  constructor( private backOfiService: BackofficeService, private route: Router ) { }

  ngOnInit(): void
  {    
    this.obtenerObrasPendientes();
    
  }

  obtenerObrasPendientes()
  {
    try 
    {
      this.backOfiService.obtenerObrasPendientes()
      .then( e => 
      { 
        if (e.status == 403 || e.status == 401) 
        {
          this.route.navigate(['/']);
          return;
        }
        this.obrasPendientes.push( ...e.message );  
      });
      
    } 
    catch (error) 
    {
      console.log(error)      
    }
  
  }

  imagenError(event: any) 
  {
    let ruta = '../../assets/default-img.png';
    event.target.src = ruta;
  }

  aprobarObra( id: any,  $event: any )
  {
    $event.preventDefault();
    this.body.id = id;
    this.body.accion = "APROBAR";

    Swal.fire({
      title: '¿Estas seguro?',
      text: "¿Realmente quieres aprobar esta obra?",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Si, hazlo!',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {        

        this.backOfiService.actualizarObrasPendientes( this.body )
        .then( e => 
          {        
            this.obrasPendientes = [];  
            this.obtenerObrasPendientes();
    
            Swal.fire({
              position: 'top-end',
              icon: 'success',
              title: 'Obra aprobada',
              showConfirmButton: false,
              timer: 1500
            });

            setTimeout( () => {
              window.location.reload();
            }, 1600);
            
          });
      }
    })   
 
  }

  rechazarObra( id: any,  $event: any )
  {
    $event.preventDefault();

    this.body.id = id;
    this.body.accion = "RECHAZAR";

    // SE CONFIRMA LA ACCION 
    Swal.fire({
      title: '¿Estas seguro?',
      text: "¿Realmente quieres rechazar esta obra?",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Si, hazlo!',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {       

        //  SE LLAMA AL SERVICIO
        this.backOfiService.actualizarObrasPendientes( this.body )
        .then( e => 
          {        
            this.obrasPendientes = [];  
            this.obtenerObrasPendientes();
    
            Swal.fire({
              position: 'top-end',
              icon: 'success',
              title: 'Obra rechazada',
              showConfirmButton: false,
              timer: 1500
            });

            setTimeout( () => {
              window.location.reload();
            }, 1600);
    
          });
      }

    })
    
   
  }

}
