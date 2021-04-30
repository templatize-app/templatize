import { Component, OnInit } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';

@Component({
  selector: 'app-topNav',
  templateUrl: './topNav.component.html',
  styleUrls: ['./topNav.component.scss']
})
export class TopNavComponent {
  constructor(public auth: AuthService) { }

}
