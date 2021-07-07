import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { NuevaPublicacion } from '../../models/index';

import { HttpClient } from '@angular/common/http';
import { AuthService } from '../auth/auth.service';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {
  
  constructor( private http: HttpClient, private auth: AuthService ) 
  {     
  }

  getInfoUser(id: any): Promise<any>
  {
    let _headers = {
      "Authorization": `bearer ${ this.auth.getToken() }`,
      "Content-Type": "application/json"    
    };

    let body = {
      "Id": id
    };

    return this.http.post<any>(`${environment.apiURL}/Usuarios/InfoUser`, body ,{ headers: _headers}).toPromise()
      .then(e => {
       
       return { status: 200, message: e };
      })
      .catch(e => {
        //console.log(e.status);
        return { status: e.status, message: e.error };
      });    
  }

  getObrasUser(id: any): Promise<any>
  {
    let _headers = {
      "Authorization": `bearer ${ this.auth.getToken() }`,
      "Content-Type": "application/json"    
    };

    let body = {
      "Id": id
    };

    return this.http.post<any>(`${environment.apiURL}/Obra/GetByUser`, body, { headers: _headers}).toPromise()
      .then(e => {
       
       return { status: 200, message: e };
      })
      .catch(e => {
        //console.log(e.status);
        return { status: e.status, message: e.error };
      }); 
  }

  getInfoArtista(): Promise<any>
  {
    let _headers = {
      "Authorization": `bearer ${ this.auth.getToken() }`,
      "Content-Type": "application/json"    
    };   

    return this.http.get<any>(`${environment.apiURL}/Usuarios/InfoArtista`, { headers: _headers}).toPromise()
      .then(e => {
       
       return { status: 200, message: e };
      })
      .catch(e => {
        //console.log(e.status);
        return { status: e.status, message: e.error };
      });    
  }

  getObrasArtista(): Promise<any>
  {
    let _headers = {
      "Authorization": `bearer ${ this.auth.getToken() }`,
      "Content-Type": "application/json"    
    };    

    return this.http.get<any>(`${environment.apiURL}/Obra/GetByArtista`, { headers: _headers}).toPromise()
      .then(e => {
       
       return { status: 200, message: e };
      })
      .catch(e => {
        //console.log(e.status);
        return { status: e.status, message: e.error };
      }); 
  }  

  nuevaPublicacion( model : NuevaPublicacion ): Promise<any>
  {
    let _headers = {
      "Authorization": `bearer ${ this.auth.getToken() }`,
      "Content-Type": "application/json"    
    };

    return this.http.post<any>(`${environment.apiURL}/Obra/Crear`, model, { headers: _headers}).toPromise()
      .then( e => {
       //console.log(e.status);
       return { status: e.status };
      })
      .catch(e => {
        //console.log(e);
        return { status: e.status, message: e };
      }); 
  }


}
