import { Component, OnInit } from '@angular/core';
import { BackofficeService } from '../services/backoffice/backoffice.service';

import { Router } from '@angular/router';
import { AuthService } from '../services/auth/auth.service';

@Component({
  selector: 'app-backoffice',
  templateUrl: './backoffice.component.html',
  styleUrls: ['./backoffice.component.scss']
})
export class BackofficeComponent implements OnInit {

  obrasPendientes: number = 0;
  artistasPendientes: number = 0;

  _publicaciones: boolean = false;   
  _registros: boolean = false;   

  constructor( private backOfiService: BackofficeService, private route: Router, private backService: BackofficeService, private auth: AuthService ) { }

  ngOnInit(): void {   }

  ngAfterViewInit() 
  {
    this.obtenerObrasPendientes();
    this.obtenerArtistasPendientes();
  }

  totalPublicaciones($event: any)
  {
    this.obrasPendientes = $event;
  }

  totalArtistas($event: any)
  {
    this.artistasPendientes = $event;
  }

  publicaciones()
  {
    this._publicaciones = true;
    this._registros = false;
  }

  registros()
  {
    this._registros = true;
    this._publicaciones = false;
  }

  obtenerObrasPendientes()
  {  
      this.backOfiService.obtenerObrasPendientes()
      .then( e => 
      {         
        //console.log(e)
        if ( e.status == 200 ) 
        {
          this.obrasPendientes = e.message.length;
          return;                
        }

        if (e.status == 403 || e.status == 401) 
        {          

          if(this.auth.getAdmin() == '__' )
          {
            this.route.navigate(['/']);    
            return;
          }
          
          if(this.auth.getAdmin() == '_' )
          {
            this.auth.logOut();
            window.location.href = '/';
            return;
          }         
        }                 
        
      });  
  }

  obtenerArtistasPendientes()
  {
    this.backService.obtenerArtistasPendientes()
    .then( e => 
      {
        if ( e.status == 200 ) 
        {
          this.artistasPendientes = e.message.length
          return;                
        }

        if (e.status == 403 || e.status == 401) 
        {
          this.auth.logOut();
          this.route.navigate(['/']);          
          return;
        }
        
      })
  }

}
