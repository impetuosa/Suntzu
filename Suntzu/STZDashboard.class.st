Class {
	#name : #STZDashboard,
	#superclass : #STZPresenter,
	#instVars : [
		'projectExplorer',
		'viewport',
		'toolbar',
		'model',
		'components',
		'mapOverviewPage',
		'angularExplorer',
		'angularModel'
	],
	#category : #Suntzu
}

{ #category : #specs }
STZDashboard class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: #toolbar
		  withConstraints: [ :constraints | 
			  constraints height: self toolbarHeight * 2 ];
		  add: (SpBoxLayout newHorizontal
				   add: #projectExplorer
				   withConstraints: [ :constraints | 
					   constraints width: self projectExplorerWidth ];
				   add: #viewport;
				   add: #angularExplorer
				   withConstraints:
					   [ :constraints | constraints width: self projectExplorerWidth ]
						   yourself);
		  yourself
]

{ #category : #'as yet unclassified' }
STZDashboard class >> projectExplorerWidth [
	^ 400
]

{ #category : #initialization }
STZDashboard >> components [

	^ components
]

{ #category : #initialization }
STZDashboard >> emptyViewport [

	mapOverviewPage ifNotNil: [ 
		viewport removePage: mapOverviewPage.
		mapOverviewPage := nil ]
]

{ #category : #'as yet unclassified' }
STZDashboard >> fullMigrateAll: aCollection [

	| migrator path modulePage selectedModule |
	path := angularExplorer pages reversed.
	modulePage := path detect: [ :p | 
		              p selectedItems anySatisfy: [ :i | 
			              i isKindOf: MOAngularModule ] ].
	selectedModule := modulePage selectedItems detect: [ :i | 
		                  i isKindOf: MOAngularModule ].
	migrator := STZMigrationManager new.
	migrator
		registerElements: aCollection;
		destination: selectedModule.
	migrator calculateComponents. 

]

{ #category : #initialization }
STZDashboard >> iconFor: anElement [

	^ (STZIcons iconFor: anElement) scaledToSize: 20@17
]

{ #category : #initialization }
STZDashboard >> informSelectingModel: aModel [

	STZViewportPageBuilder new buildPageFor: aModel into: viewport
]

{ #category : #initialization }
STZDashboard >> initializePresenters [

	super initializePresenters.
	toolbar := self newToolbar.
	toolbar beBoth.
	toolbar
		addItemLeft: (SpToolbarButtonPresenter  new
				 label: 'Access';
				 icon: (self theme iconNamed: #smallOpen);
				 help: 'Opens an access project';
				 action: [ self openAccessProject ];
				 yourself);
		addItemLeft: (SpToolbarButtonPresenter new
				 label: 'Accueil';
				 icon: (self theme iconNamed: #smallOpen);
				 help: 'Opens CAcceuille project';
				 action: [ 
					 self openAccueille];
				 yourself);
		addItemLeft: (SpToolbarButtonPresenter new
				 label: 'NW';
				 icon: (self theme iconNamed: #smallOpen);
				 help: 'Opens Northwind project';
				 action: [ 
					self openNorthwind ];
				 yourself);
		addItemLeft: (SpToolbarButtonPresenter new
				 label: 'TreeMap';
				 icon: (self theme iconNamed: #branch);
				 help: 'Tree map overview';
				 action: [ self openTreeMapOverview ];
				 yourself);
		addItemRight: (SpToolbarButtonPresenter new
				 label: 'Angular';
				 icon: (self theme iconNamed: #smallOpen);
				 help: 'openAngularProject';
				 action: [ self openAngularProject ];
				 yourself);
		addItemRight: (SpToolbarButtonPresenter new
				 label: 'CW3';
				 icon: (self theme iconNamed: #smallOpen);
				 help: 'Open core web 3 ';
				 action: [ self openCW3];
				 yourself).
	projectExplorer := self newProjectExplorer .
	angularExplorer := self newProjectExplorer .

	viewport := self newNotebook
]

{ #category : #initialization }
STZDashboard >> initializeWindow: aWindowPresenter [ 	
	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenWillCloseDo: [ self windowClosing ].
]

{ #category : #'as yet unclassified' }
STZDashboard >> inspectCasinoModelFor: aCollection [

	| man |
	man := STZMigrationManager new.

	man registerElements: aCollection.
	man loadCasinoModel inspect
]

{ #category : #initialization }
STZDashboard >> newProjectExplorer [

	^ SpMillerColumnPresenter new
		  presenterBlock: [ :aModel | 
				self informSelectingModel: aModel. 
				STZInspectorBuilder new inspectorFor: aModel into: self.
			 ];
		  yourself
]

{ #category : #initialization }
STZDashboard >> open [

	<script: 'self new openWithSpec '>
	
]

{ #category : #initialization }
STZDashboard >> openAccessProject [

	| path |
	path := UIManager default
		        chooseFullFileNameMatching: nil
		        label: 'Access project'.
	path ifNil: [ ^ self ].
	path := path asFileReference.
	path exists ifFalse: [ 
		UIManager default inform: 'Invalid file'.
		^ self ].

	self openAccessProject: path
]

{ #category : #initialization }
STZDashboard >> openAccessProject: path [

	model ifNotNil: [ 
		(UIManager default
			 confirm:
			 'Open a new project requires to close the already opened one. Do you want to continue?'
			 label: 'Close project?')
			ifTrue: [ 
				model closeAndQuit.
				model := nil ]
			ifFalse: [ ^ self ] ].

	model := JinAccessMooseModel new
		         path: path asFileReference;
		         yourself.
	mapOverviewPage ifNotNil: [ 
		mapOverviewPage presenterProvider model: model ].
	components := Set new.
	projectExplorer setRootModel: model
]

{ #category : #initialization }
STZDashboard >> openAccueille [

	self openAccessProject:
		'D:\Users\Santiago.BRAGAGNOLO\Documents\PhD\Resources\11.50.00.02\Produit\caccueil.accdb'
			asFileReference
]

{ #category : #initialization }
STZDashboard >> openAngularProject [

	| path |
	path := UIManager default
		        chooseFullFileNameMatching: nil
		        label: 'Angular project'.
	path ifNil: [ ^ self ].
	path := path asFileReference.
	path exists ifFalse: [ 
		UIManager default inform: 'Invalid file'.
		^ self ].

	self openAngularProject: path
]

{ #category : #'as yet unclassified' }
STZDashboard >> openAngularProject: aFileReference [

	angularModel ifNotNil: [ 
		(UIManager default
			 confirm:
			 'Open a new project requires to close the already opened one. Do you want to continue?'
			 label: 'Close project?')
			ifTrue: [ 
				angularModel closeAndQuit.
				angularModel := nil ]
			ifFalse: [ ^ self ] ].

	angularModel := MOAngularScheme onPath: aFileReference.


	angularExplorer setRootModel: angularModel
]

{ #category : #initialization }
STZDashboard >> openCW3 [ 
	self openAngularProject: 'D:\Users\Santiago.BRAGAGNOLO\Documents\git-repositories\coreweb3\export' asFileReference 
]

{ #category : #initialization }
STZDashboard >> openNorthwind [

	self openAccessProject:
		'D:\Users\Santiago.BRAGAGNOLO\Documents\norwind\Northwind.accdb'
			asFileReference
]

{ #category : #initialization }
STZDashboard >> openTreeMapOverview [

	| widget |
	model ifNil: [ UIManager inform: 'none project is opened!' .^ self ].
	mapOverviewPage ifNotNil: [ ^ self ].

	widget := self instantiate: STZTreeMapPresenter.

	mapOverviewPage := self newNotebookPage
		                   beCloseable;
		                   title: '';
		                   presenterProvider: widget;
		                   yourself.
	viewport addPage: mapOverviewPage.
	viewport selectPage: mapOverviewPage.
	widget needRebuild: true.
	self update.
	widget model: model
]

{ #category : #accessing }
STZDashboard >> project [
	^ model 
]

{ #category : #initialization }
STZDashboard >> tableContents [

	^ model entities 
]

{ #category : #initialization }
STZDashboard >> windowClosing [

	model ifNotNil: [ model ensureClosed ]
]
