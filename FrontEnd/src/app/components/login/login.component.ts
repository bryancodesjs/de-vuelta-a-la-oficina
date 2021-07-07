import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import { Router } from '@angular/router';

import { AuthService } from 'src/app/services/auth/auth.service';

import { LoginService } from './../../services/login/login.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})

export class LoginComponent implements OnInit {

  submitted = false;
  error = false;
  messageError = '';

  // GRUPO DE ELEMENTOS PARA FORMULARIO DE LOGIN
  loginForm = new FormGroup({
    email: new FormControl('', Validators.required),
    clave: new FormControl('', Validators.required)
  });

  constructor( private loginService: LoginService, private auth: AuthService, private route: Router ) { }

  ngOnInit(): void 
  {
    if(this.auth.authorized())
    {
      this.route.navigate(['/']);
    }

  }

  get f() { return this.loginForm.controls; }

  submit()
  {
    this.submitted = true;    

    if (this.loginForm.invalid) {
      return;
    }
   
    this.loginService.LoginPost(this.loginForm.value)
    .then( res => {
            
      if(res.status == 200)
      {
        if (res.redirect == '/dashboard') 
        {         
          this.auth.setUser();
        }
        if (res.redirect == '/backoffice') 
        {         
          this.auth.setAdmin();
        }
        this.route.navigate([res.redirect]);
      }
      else
      {
        this.submitted = false;    
        this.error = true;
        this.messageError = res.message != null ? res.message : 'Algo no anda bien, vuelva mas tarde...' ;
      }
  
    });
    
  }


}
