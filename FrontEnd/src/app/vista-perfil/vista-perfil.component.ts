import { Component, OnInit, HostListener } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from '../services/auth/auth.service';
import { DashboardService } from '../services/dashboard/dashboard.service';

@Component({
  selector: 'app-vista-perfil',
  templateUrl: './vista-perfil.component.html',
  styleUrls: ['./vista-perfil.component.scss']
})
export class VistaPerfilComponent implements OnInit {

  obras: any = [];
  idUser: any = 0;

  infoUser: any = '';
  error: boolean = false;
  currentUser: any = '';
  
  //La siguiente funcion escucha el evento de scroll para reposicionar el card con la info del artista
  @HostListener("window:scroll", ['$event'])
  scrollRead(){
    //let scrollOffset = $event.srcElement.children[0].scrollTop;
    let number = scrollY; //offset vertical de la pantalla
    let screenWidth = screen.width; //ancho de pantalla
    let user = document.getElementById('userField'); //el card con la info del artista
    if (screenWidth >= 992 ) { //si el ancho de pantalla es mayor a 992px...
      if (number > 0) {
        number >  241 ? user?.setAttribute("style", "transform: translateY(100px); transition: ease 1s;") : user?.setAttribute("style", "transform: translateY(0px); transition: ease 1s;");
        //console.log(number);
      }
    }
  }

  constructor( private _route: ActivatedRoute, private dashService: DashboardService, private auth: AuthService, private route: Router ) 
  {    
    this.idUser = this._route.snapshot.paramMap.get('id');
  }

  ngOnInit(): void 
  {
    this.getInfoUser( this.idUser ); 
    this.getObras( this.idUser );
  }

  getObras(id: any)
  {
    this.dashService.getObrasUser( id )
    .then( e => { 
      //console.log(e)
      if ( e.status == 200 ) 
      {        
        this.obras.push(...e.message.obras);        
      }
      
    });
  }

  getInfoUser(id: any)
  {
    this.dashService.getInfoUser(id)
    .then( e => 
      {       
        this.currentUser = this.auth.getUser(); 
        const { status, message } = e;

        if (status == 0) 
        {
          this.error = true;
          return;
        }

        if (status == 200) 
        {
          this.infoUser = message;
          //console.log(this.infoUser);  
          this.error = false;
        }
    
      });
  }

  imagenError(event: any) 
  {    
    event.target.src = '../../assets/default-img.png';
  }
  
  

}
