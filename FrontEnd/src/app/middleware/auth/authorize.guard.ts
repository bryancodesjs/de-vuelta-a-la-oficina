import { Injectable } from '@angular/core';
import { CanActivate } from '@angular/router';
import { Router } from '@angular/router';
import { BackofficeService } from 'src/app/services/backoffice/backoffice.service';

import { AuthService } from '../../services/auth/auth.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate 
{
  result: any = null;

  constructor( private auth: AuthService, private routes: Router, private backOfiService: BackofficeService ) {}

  canActivate(): any
  {     
      if (this.authorizedAdmin()) 
      {
        return true;
      }
      else
      {
        return this.routes.navigate(['/']);      
      }
  }

  authorizedAdmin()
  { 
    return this.backOfiService.obtenerObrasPendientes()
    .then( e => 
    { 
      if (e.status === 200) 
      {          
        return true;       
      }
      else
      {    
        return false;
      }       
    });  
   
  }
  
}
