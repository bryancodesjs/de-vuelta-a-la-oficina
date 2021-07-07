import { Injectable } from '@angular/core';
import { CanActivate } from '@angular/router';
import { Router } from '@angular/router';

import { AuthService } from '../../services/auth/auth.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate 
{
  constructor( private auth: AuthService, private routes: Router ) {}

  canActivate(): any
  {
      if (this.auth.authorized()) 
      {
        return true;
      }
      else
      {
        return this.routes.navigate(['/']);      
      }   

  }
  
}
