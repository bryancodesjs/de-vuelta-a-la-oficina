
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { AuthService } from 'src/app/services/auth/auth.service';
import { ConfiguracionService } from 'src/app/services/configuracion/configuracion.service';
import { DashboardService } from 'src/app/services/dashboard/dashboard.service';

import Swal from 'sweetalert2';

@Component({
  selector: 'app-configuracion',
  templateUrl: './configuracion.component.html',
  styleUrls: ['./configuracion.component.scss']
})
export class ConfiguracionComponent implements OnInit {  

  misDatos: boolean = true;
  personalizacion: boolean = false;
  contacto: boolean = false;
  seguridad: boolean = false;

  submit: boolean = false;
  errorClave: boolean = false;

  misDatosForm = new FormGroup({
    id: new FormControl(''),
    nombre: new FormControl('', Validators.required),
    apellido: new FormControl('', Validators.required),
    profesion: new FormControl('', Validators.required),
    descripcion: new FormControl('', Validators.required)
  });

  contactoForm = new FormGroup({
    id: new FormControl(''),
    facebook: new FormControl('', Validators.required),
    youtube: new FormControl('', Validators.required),
    instagram: new FormControl('', Validators.required),
    email: new FormControl('', Validators.required)
  });

  nuevaClaveForm = new FormGroup({
    id: new FormControl(''),
    actual: new FormControl('', Validators.required),
    nueva: new FormControl('', Validators.required),
    confirmar_nueva: new FormControl('', Validators.required)        
  });

  constructor( private dashService: DashboardService, private auth: AuthService, private configService: ConfiguracionService ) 
  {     
    
  }

  ngOnInit(): void 
  {
    this.datosArtista();    
  }

  get seguridadControls() { return this.nuevaClaveForm.controls; }

  submitMisDatos()
  {  
    console.log( this.misDatosForm.value );
  }

  submitSeguridad()
  {  
    this.submit = true;
    this.errorClave = false;
    //console.log(this.nuevaClaveForm.value)

    if (this.nuevaClaveForm.invalid ) 
    {      
      return;
    }

    if (this.nuevaClaveForm.value.nueva != this.nuevaClaveForm.value.confirmar_nueva) 
    {
      this.errorClave = true;
      return;
    }

    this.configService.cambiarClave( this.nuevaClaveForm.value )
    .then( e => 
      {
        //console.log(e)
        if (e.status == 200) 
        {
          Swal.fire({
            position: 'top-end',
            icon: 'success',
            title: 'Cambios realizados!',
            showConfirmButton: false,
            timer: 1500
          });

          setTimeout(() => {
            document.location.reload();
          }, 1600);
        }

        if (e.status == 404) 
        {
          Swal.fire({
            position: 'top-end',
            icon: 'error',
            title: e.message,
            showConfirmButton: false,
            timer: 2300
          });
        }
        
      });    
  }

  datosArtista()
  {
    this.dashService.getInfoArtista()
    .then( e => 
      {    
        const { status, message } = e;
        if (status == 200)
        {          
          const { id, nombre, apellido, descripcionGeneral, profesion, facebook, instagram, youtbe, email } = message;

          // MIS DATOS
          this.misDatosForm.controls['id'].setValue( id );
          this.misDatosForm.controls['nombre'].setValue( nombre );
          this.misDatosForm.controls['apellido'].setValue( apellido );
          this.misDatosForm.controls['profesion'].setValue( profesion );
          this.misDatosForm.controls['descripcion'].setValue( descripcionGeneral );

          // CONTACTO          
          this.contactoForm.controls['id'].setValue( id );
          this.contactoForm.controls['facebook'].setValue( facebook == null ? 'Digite su usuario' : facebook );
          this.contactoForm.controls['youtube'].setValue( instagram == null ? 'Digite su usuario' : instagram );
          this.contactoForm.controls['instagram'].setValue( youtbe == null ? 'Digite su usuario' : youtbe );
          this.contactoForm.controls['email'].setValue( email );

          // SEGURIDAD 
          this.nuevaClaveForm.controls['id'].setValue( id );
        }

        if (status == 401) 
        {
           this.auth.logOut();
           document.location.href = '/';  
        }
    
      });
  }

  select( opcion: string )
  {
    switch (opcion) {

      case 'misdatos':
        this.misDatos = true;
        this.personalizacion = false;
        this.contacto = false;
        this.seguridad = false;
        break;

      case 'personalizacion':
        this.personalizacion = true;
        this.misDatos = false;        
        this.contacto = false;
        this.seguridad = false;
        break;

      case 'contacto':
        this.contacto = true;
        this.misDatos = false;
        this.personalizacion = false;        
        this.seguridad = false;
        break;
      case 'seguridad':
        this.seguridad = true;
        this.misDatos = false;
        this.personalizacion = false;
        this.contacto = false;        
        break;

      default:
        this.misDatos = false;
        this.personalizacion = false;
        this.contacto = false;
        this.seguridad = false;
        break;
    }
  }

}