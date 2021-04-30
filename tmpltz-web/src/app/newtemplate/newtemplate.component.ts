import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { STEPPER_GLOBAL_OPTIONS } from '@angular/cdk/stepper';
import { ContentChange, QuillEditorComponent } from 'ngx-quill';
import { debounceTime, distinctUntilChanged, tap } from 'rxjs/operators';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { v4 as uuidv4 } from 'uuid';
import { AuthService } from '@auth0/auth0-angular';

@Component({
  selector: 'app-newtemplate',
  templateUrl: './newtemplate.component.html',
  styleUrls: ['./newtemplate.component.scss'],
  providers: [{
    provide: STEPPER_GLOBAL_OPTIONS, useValue: {displayDefaultIndicatorType: false}
  }]
})

export class NewtemplateComponent implements OnInit {
  firstFormGroup: FormGroup;
  secondFormGroup: FormGroup;

  @ViewChild('editor', {
    static: true
  }) editor: QuillEditorComponent;

  variablesFound: string[];

  constructor(
    private _formBuilder: FormBuilder, 
    private http: HttpClient, 
    public auth: AuthService
  ) {}
   
  ngOnInit(): void {
    this.firstFormGroup = this._formBuilder.group({
      title: ['', Validators.required],
      templateText: ['', Validators.required]
    });
    this.secondFormGroup = this._formBuilder.group({
      secondCtrl: ['', Validators.required]
    });

    this.editor
      .onContentChanged
      .pipe(
        debounceTime(400),
        distinctUntilChanged()
      )
      .subscribe((data: ContentChange) => {
        const regexp = /\$\{(.*?)\}/g; 
        this.variablesFound = data.text == null ? [] : [...new Set(data.text!.match(regexp))] || [];
    })
  }
  createTemplate(): void {
    this.http.put('/template',
      {
        id: uuidv4(),
        template: this.firstFormGroup.controls.templateText.value,
        name: this.firstFormGroup.controls.title.value
      },
      {
        headers: new HttpHeaders({ 'Content-Type': 'application/json' })
      }
    )
      .subscribe(result => console.log(result));
  }
}
