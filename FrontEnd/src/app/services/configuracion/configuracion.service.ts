import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AuthService } from '../auth/auth.service';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ConfiguracionService {

  constructor( private auth: AuthService, private http: HttpClient ) { }


  cambiarClave( model: any )
  {
    let headers = {
      "Authorization": `bearer ${ this.auth.getToken() }`,
      "Content-Type": "application/json"    
    };   

    return this.http.post<any>(`${environment.apiURL}/PerfilUsuario/CambiarClave`, model ,{ headers: headers }).toPromise() 
    .then( e =>      
      { 
          return { status: e.status, message: null };
      })
    .catch( e => 
      {        
        return { status: e.status, message: e.error.message };   
      }); 
  }


}
