import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import { environment } from '../../../environments/environment';

import { LoginModel, RegistroModel } from './../../models';
import { AuthService } from '../auth/auth.service';


@Injectable({
  providedIn: 'root'
})
export class LoginService {

  constructor( private http: HttpClient, private auth: AuthService ) { }

  headers = {
    "Content-Type": "application/json"
  };

  LoginPost( model: LoginModel ): Promise<any>
  { 
    return this.http.post<any>(`${environment.apiURL}/Login`, model , { headers: this.headers }).toPromise()
    .then( async e => 
      {
        if (e.codeStatus === 200) 
        {
          await this.auth.infoUser( e.usuarioActual, e.token, e.id );          

          return { status: e.codeStatus, redirect: e.redirect } 
        }
        else
        {
          return { status: e.error.codeStatus, message: e.error.message };
        }
        
      })
    .catch( e => 
      {
        //console.log(e);
        return { status: e.status, message: e.error.message };
      });    
    
  }

  registroPost(model: RegistroModel): Promise<any>
  {    
    return this.http.post<any>(`${environment.apiURL}/Usuarios/Crear`, model, { headers: this.headers }).toPromise()
    .then( async e => 
      {
        //console.log(e);
        if (e.codeStatus === 200) 
        {
          await this.auth.infoUser( e.usuarioActual, e.token, e.id );
          // this.auth.setUser(e.usuarioActual);
          // this.auth.setToken(e.token);

          return { status: e.codeStatus } 
        }
        else
        {
          return { status: e.codeStatus, message: e.message };
        }      
        
      })
    .catch( e => 
      {
        //console.log(e);
        return { status: 404, message: e.error };
      });  
  }

}
