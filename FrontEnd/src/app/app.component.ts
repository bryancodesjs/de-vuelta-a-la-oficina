import { Component } from '@angular/core';
import { Location } from "@angular/common";
import { Router } from "@angular/router";

import { AuthService } from './services/auth/auth.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  
  title = 'directorio-creativo';

  current: any;

  constructor( private auth: AuthService, private router: Router ) 
  { 
    
    this.router.events.subscribe((val) => {
      this.current = this.router.url;       
   });

  }
  
  check()
  {

    if (this.current == '/login') 
    {
      return true;  
    }
    else if(this.current == '/registro')
    {
      return true;
    }
    else
    {
      return false;
    }

  }


}
