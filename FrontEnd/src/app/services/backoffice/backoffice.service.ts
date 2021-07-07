import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

import { environment } from '../../../environments/environment';
import { AuthService } from '../auth/auth.service';

import { ActualizarObraPendiente, Artista } from '../../models';

@Injectable({
  providedIn: 'root'
})
export class BackofficeService {

  constructor( private http: HttpClient, private auth: AuthService ) {  }

  obtenerObrasPendientes(): Promise<any>
  {
    let headers = {
      "Authorization": `bearer ${ this.auth.getToken() }`,
      "Content-Type": "application/json"    
    };

    return this.http.get<any>(`${environment.apiURL}/Obra/Pendiente`, { headers: headers }).toPromise() 
    .then( e =>      
      { 
          return { status: e.status, message: e.message };
      })
    .catch( e => 
      {        
        return { status: e.status };   
      }); 
  }

  actualizarObrasPendientes( model: ActualizarObraPendiente ): Promise<any>
  { 
    let headers = {
      "Authorization": `bearer ${ this.auth.getToken() }`,
      "Content-Type": "application/json"    
    };

    return this.http.put<any>(`${environment.apiURL}/Obra/ActualizarObraPendiente`, model , { headers: headers }).toPromise() 
    .then( e => 
      {
        return { status: 200, message: e };   
      })
    .catch( e => 
      {     
        return { status: 404, message: e };   
      }); 
  }

  obtenerArtistasPendientes()
  {
    let headers = {
      "Authorization": `bearer ${ this.auth.getToken() }`,
      "Content-Type": "application/json"    
    };

    return this.http.get<any>(`${environment.apiURL}/Usuarios/ArtistasPendientes`, { headers: headers }).toPromise() 
    .then( e => 
      {
        return { status: 200, message: e };   
      })
    .catch( e => 
      {     
        return { status: e.status, message: e };   
      });
  }

  aprobarArtista( id: Artista ): Promise<any>
  {
    let headers = {
      "Authorization": `bearer ${ this.auth.getToken() }`,
      "Content-Type": "application/json"    
    };

    return this.http.put<any>(`${environment.apiURL}/Usuarios/AprobarArtista`, id , { headers: headers }).toPromise() 
    .then( e => 
      {
        return { status: 200 };   
      })
    .catch( e => 
      {     
        return { status: e.status, message: e };   
      }); 
  }

  rechazarArtista( id: Artista ): Promise<any>
  {
    let headers = {
      "Authorization": `bearer ${ this.auth.getToken() }`,
      "Content-Type": "application/json"    
    };

    return this.http.put<any>(`${environment.apiURL}/Usuarios/RechazarArtista`, id , { headers: headers }).toPromise() 
    .then( e => 
      {
        return { status: 200 };   
      })
    .catch( e => 
      {     
        return { status: e.status, message: e };   
      }); 
  }


}
