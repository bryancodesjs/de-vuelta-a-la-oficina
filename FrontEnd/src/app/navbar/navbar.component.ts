import { Component, OnInit } from '@angular/core';
import { AuthService } from '../services/auth/auth.service';

import { Router } from '@angular/router';
import { DashboardService } from '../services/dashboard/dashboard.service';
import { BackofficeService } from '../services/backoffice/backoffice.service';

import Swal from 'sweetalert2';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent implements OnInit  {

  currentUser: any = null;
  admin: boolean = false;

  constructor( private auth: AuthService, private route: Router, private dashService: DashboardService, private backOfiService: BackofficeService ) { }

  ngOnInit(): void 
  {
    if ( this.auth.getId() != null) 
    {
      this.getUser( this.auth.getId() );

      if ( this.auth.getAdmin() == '_' ) 
      {
        this.admin = true;
      }
      else
      {
        this.admin = false;
      }
    }
    else
    {
      this.currentUser = null;
      this.admin = false;
    }   
    
  } 

  getUser( id: number )
  {  
    this.currentUser = this.auth.getUser();

    this.dashService.getInfoUser( id )
    .then( e => 
      {
          if( e.status == 401 )
          {
              this.currentUser = null;
              this.auth.logOut();
              return;
          }
      });    
  }

  // isAdmin()
  // {
  //     this.backOfiService.obtenerObrasPendientes()
  //     .then( e => 
  //     { 
  //       //console.log(e)
  //       if (e.status == 403 || e.status == 401) 
  //       { 
  //         this.auth.setAdmin();
  //         return;
  //       }
  //       else
  //       {
  //         this.admin = true;       
  //         return;
  //       }       
         
  //     }); 
  // }

  LogOut()
  {
    Swal.fire({
      title: '¿Estas seguro?',
      text: "¿Realmente quieres cerrar sesion?",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Si, hazlo!',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) { 
        this.currentUser = null;
        this.admin = false;
        this.auth.logOut();
        this.route.navigate(['/']);      
      }
    })



    
  }

}
