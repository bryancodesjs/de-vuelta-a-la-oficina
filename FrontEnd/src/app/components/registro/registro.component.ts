import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { RegistroModel } from 'src/app/models';
import { AuthService } from 'src/app/services/auth/auth.service';
import { LoginService } from 'src/app/services/login/login.service';

@Component({
  selector: 'app-registro',
  templateUrl: './registro.component.html',
  styleUrls: ['./registro.component.scss']
})
export class RegistroComponent implements OnInit {

  submitted = false;
  claveError = false;
  error = false;
  messageError = '';

  registroForm = new FormGroup({
    nombre: new FormControl('', Validators.required),
    apellido: new FormControl('', Validators.required),
    email: new FormControl('', Validators.required),
    telefono: new FormControl('', Validators.required),
    _idprovincia: new FormControl('', Validators.required),   
    clave: new FormControl('', Validators.required),
    confirmar_clave: new FormControl('', Validators.required),
  });

  constructor( private loginService: LoginService, private route: Router, private auth: AuthService ) { }

  ngOnInit(): void 
  {  
    if(this.auth.authorized())
    {
      this.route.navigate(['/']);
    }
  }

  get f() { return this.registroForm.controls; }

  submit()
  {
    this.submitted = true;
    this.claveError = false;  

    if (this.registroForm.invalid) 
    {
      this.submitted = false;
      return;
    }

    if (this.registroForm.value.clave !== this.registroForm.value.confirmar_clave) 
    {
      this.claveError = true;        
      return;
    }

    const { nombre, apellido, email, telefono, _idprovincia, clave } = this.registroForm.value;
    let formData: RegistroModel;
    let idprovincia = parseInt(_idprovincia);
    formData = 
    {
      nombre,
      apellido,
      email,
      telefono,
      idprovincia,      
      clave
    }
   
    this.loginService.registroPost(formData)
    .then( e => 
      { 
        if(e.status == 200)
        {
          this.submitted = false;
          this.error = false;

          this.route.navigate(['/']);
        } 
        else
        {
          this.submitted = false;    
          this.error = true;
          this.messageError = e.message;
        }

      });
    
  }

}
