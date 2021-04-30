import { Component, OnInit } from '@angular/core';
import { Template } from '../template';

@Component({
  selector: 'app-template',
  templateUrl: './template.component.html',
  styleUrls: ['./template.component.scss']
})
export class TemplateComponent implements OnInit {
  template: Template = {
    id: "tmplt",
    name: 'Windstorm',
    owner: 'tmpltz',
    text: 'the quick brown fox jumps over the lazy dog'
  };


  constructor() { }

  ngOnInit(): void {
  }

}
