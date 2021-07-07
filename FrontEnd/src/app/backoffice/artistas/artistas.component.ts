import { Component, OnInit } from '@angular/core';
import { BackofficeService } from 'src/app/services/backoffice/backoffice.service';
import { Artista } from '../../models';

import Swal from 'sweetalert2';

@Component({
  selector: 'app-artistas',
  templateUrl: './artistas.component.html',
  styleUrls: ['./artistas.component.scss']
})
export class ArtistasComponent implements OnInit {
  _artistasPendientes: any[] = [];  

  constructor( private backService: BackofficeService ) { }

  ngOnInit(): void { this.artistasPendientes() }

  artistasPendientes()
  {
    this.backService.obtenerArtistasPendientes()
    .then( e => 
      {
        if ( e.status == 200 ) 
        {
          this._artistasPendientes = [];
          this._artistasPendientes.push( ...e.message );          
        }
        //console.log(this._artistasPendientes);
      })
  }

  aprobarArtista( id: any )
  {
    let model: Artista = 
    {
      Id: id
    }

    Swal.fire({
      title: '¿Estas seguro?',
      text: "¿Realmente quieres aceptar este artista?",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Si, hazlo!',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) { 
        
        this.backService.aprobarArtista( model )
        .then( e => 
          {
            if (e.status == 200) 
            {
              this.artistasPendientes();

              Swal.fire({
                position: 'top-end',
                icon: 'success',
                title: 'Artista aceptado...',
                showConfirmButton: false,
                timer: 1500
              });

              setTimeout( () => {
                window.location.reload();
              }, 1600);

            }
          });
        
      }
    }) 

  }

  rechazarArtista( id: any )
  {
     let model: Artista = 
    {
      Id: id
    }

    Swal.fire({
      title: '¿Estas seguro?',
      text: "¿Realmente quieres rechazar este artista?",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Si, hazlo!',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) { 
        
        this.backService.rechazarArtista( model )
        .then( e => 
          {
            if (e.status == 200) 
            {
              this.artistasPendientes();
              
              Swal.fire({
                position: 'top-end',
                icon: 'success',
                title: 'Artista rechazado...',
                showConfirmButton: false,
                timer: 1500
              });

              setTimeout( () => {
                window.location.reload();
              }, 1600);

            }
          });
        
      }
    }) 
  }


}
