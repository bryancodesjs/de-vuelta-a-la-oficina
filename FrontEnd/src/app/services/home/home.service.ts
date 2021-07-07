import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

import { environment } from '../../../environments/environment';
import { AuthService } from '../auth/auth.service';

@Injectable({
  providedIn: 'root'
})
export class HomeService {  

  token: any = '';

  constructor( private http: HttpClient, private auth: AuthService ) 
  { 
    this.token = this.auth.getToken();    
  }  

  obtenerGaleria( oderBy: string ): Promise<any>
  {

    let headers = {
      "Authorization": `bearer ${this.token}`,
      "Content-Type": "application/json"    
    };

    let body = {
      "Filtro": oderBy
    }

    return this.http.post<any>(`${environment.apiURL}/Obra/Get`, body, { headers: headers }).toPromise() 
    .then( e => 
      {
        if (e.codeStatus === 200) 
        {
          return { status: e.codeStatus, message: e.message } 
        }
        else
        {
          return { status: e.codeStatus, message: e.message };
        }
        
      })
    .catch( e => 
      {        
        return { status: e.status, message: e.error };
      }); 
  }


}
