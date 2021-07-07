import { Component, OnInit } from '@angular/core';
import { HomeService } from '../services/home/home.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  ordenar: string = '';

  galeria: any = [];
  showModal: boolean = false;
  loading: boolean = true;
  error: boolean = false;

  obraModal = {
    id: 0,
    artista: '',
    imgObra: '',
    nombreObra: '',
    fechaRegistro: '',
    ubicacion: '',
    valoraciones: 0,
    visitas: 0    
  };

  imgLoading: string = '../../assets/img/loading.gif';

  constructor( private homeService: HomeService ) {  }

  ngOnInit(): void 
  {    
  } 

  ngAfterViewInit()
  {
    this.cargarGaleria();
  }

  Ordenar( _ordenar: any )
  {
    this.ordenar = _ordenar;    
    this.cargarGaleria();
  }

  cargarGaleria()
  {
    this.homeService.obtenerGaleria( this.ordenar )
    .then( (e: any) => 
      {
        //console.log(e)
        if (e.status == 0) 
        {
          this.error = true; 
          return;
        }

        const { message } = e;
        this.galeria = message; 
        this.loading = false;
        this.error = false; 
      });
  }
  
  show( id: any )
  {
    this.showModal = true;    
    this.obraModal.id = id.id;
    this.obraModal.artista = id.artista;
    this.obraModal.imgObra = id.imgObra;
    this.obraModal.nombreObra = id.nombreObra;
    this.obraModal.fechaRegistro = id.fechaRegistro;
    this.obraModal.valoraciones = id.valoraciones;
    this.obraModal.visitas = id.visitas;
    // console.log(this.obraModal)
  }

  hide()
  {
    this.showModal = false;    
  }

  imagenError(event: any) 
  {    
    event.target.src = '../../assets/default-img.png';
  }



}
