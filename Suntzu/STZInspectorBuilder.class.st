Class {
	#name : #STZInspectorBuilder,
	#superclass : #JinVisitor,
	#instVars : [
		'inspector',
		'owner'
	],
	#category : #Suntzu
}

{ #category : #'visit angular' }
STZInspectorBuilder >> createIconNameTable [

	| table |
	
	table := self newTable.
	table
		addColumn:
			((SpImageTableColumn
				  title: 'Icon'
				  evaluated: [ :e | self iconFor: e ])
				 width: 50;
				 yourself);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		activateOnDoubleClick;
		beMultipleSelection;
		contextMenu: (self tableMenuForAngular: table);
		beResizable.
		
		
	^ table
]

{ #category : #'as yet unclassified' }
STZInspectorBuilder >> iconFor: anElement [
	^ owner iconFor: anElement 
]

{ #category : #'as yet unclassified' }
STZInspectorBuilder >> inspectorFor: anObject into: anOwner [
	owner := anOwner. 
	anObject acceptVisitor: self.
	^ inspector 
]

{ #category : #'as yet unclassified' }
STZInspectorBuilder >> newMenu [

	^ owner newMenu
]

{ #category : #'as yet unclassified' }
STZInspectorBuilder >> newTable [
	^ owner newTable
]

{ #category : #visiting }
STZInspectorBuilder >> saveIntoProject: aCollection [ 
	aCollection do: [ : c | c save ].
]

{ #category : #initialization }
STZInspectorBuilder >> tableMenuFor: table1 [

	^ self newMenu

		  addGroup: [ :aGroup | 
			  aGroup
				  addItem: [ :anItem | 
					  anItem
						  name: 'Print in transcript';
						  shortcut: $p meta;
						  description: 'Print the selected class on Transcript';
						  action: [ table1 selectedItems traceCr ] ];
				  addItem: [ :anItem | 
					  anItem
						  name: 'Browse';
						  iconName: #open;
						  action: [ table1 selectedItems browse ] ];
				  addItem: [ :anItem | 
					  anItem
						  name: 'Print infos';
						  subMenu: (self newMenu addGroup: [ :aSubGroup | 
									   aSubGroup
										   addItem: [ :item | 
											   item
												   name: 'Print number of methods';
												   action: [ table1 selectedItems methods size traceCr ] ];
										   addItem: [ :item | 
											   item
												   name: 'Print number of variables';
												   action: [ 
													   table1 selectedItems instanceVariables size
														   traceCr ] ] ]) ] ]
]

{ #category : #initialization }
STZInspectorBuilder >> tableMenuForAngular: aTable [

	^ self newMenu addGroup: [ :aGroup | 
		  aGroup
			  addItem: [ :anItem | 
				  anItem
					  name: 'Inspect';
					  description: 'Inspect';
					  action: [ aTable selectedItems inspect ] ];
			  addItem: [ :anItem | 
				  anItem
					  name: 'Save';
					  description: 'Save into project';
					  action: [ self saveIntoProject: inspector selectedItems ] ].
		  aGroup addItem: [ :menuItem | 
			  menuItem
				  name: 'New';
				  subMenu: (self newMenu addGroup: [ :newGroup | 
							   newGroup
								   addItem: [ :anItem | 
									   anItem
										   name: 'Create new module';
										   description: 'new module';
										   action: [ owner createNewAngularModule ] ];
								   addItem: [ :anItem | 
									   anItem
										   name: 'New component';
										   description: 'Create New Component';
										   action: [ owner createNewAngularComponent ] ];
								   addItem: [ :anItem | 
									   anItem
										   name: 'New model';
										   description: 'Create New Model';
										   action: [ owner createNewAngularModel ] ] ]) ] ]
]

{ #category : #initialization }
STZInspectorBuilder >> tableMenuForQuery: aTable [

	^ self newMenu
		  addGroup: [ :aGroup | 
			  aGroup addItem: [ :anItem | 
					  anItem
						  name: 'Inspect';
						  shortcut: $i meta;
						  description: 'Inspect';
						  action: [ aTable selectedItems inspect ] ] ]
]

{ #category : #initialization }
STZInspectorBuilder >> tableMenuForTable: aTable [

	^ self newMenu

		  addGroup: [ :aGroup | 
			  aGroup addItem: [ :anItem | 
					  anItem
						  name: 'Inspect';
						  shortcut: $i meta;
						  description: 'Inspect';
						  action: [ aTable selectedItems inspect ] ] ]
]

{ #category : #initialization }
STZInspectorBuilder >> tableMenuForms: aTable [

	^ self newMenu
		  addGroup: [ :aGroup | 
			  aGroup
				  addItem: [ :anItem | 
					  anItem
						  name: 'Inspect';
						  shortcut: $i meta;
						  description: 'Inspect';
						  action: [ aTable selectedItems inspect ] ];
		
				  addItem: [ :anItem | 
					  anItem
						  name: 'Selective Migration';
						  description: 'Migrate UI Selecting new Component';
						  action: [ owner selectiveMigrateAll: aTable selectedItems ] ] ]
]

{ #category : #initialization }
STZInspectorBuilder >> tableMenuProject: aTable [

	^ self newMenu
		  addGroup: [ :aGroup | 
			  aGroup
				  addItem: [ :anItem | 
					  anItem
						  name: 'Inspect';
						  shortcut: $i meta;
						  description: 'Inspect';
						  action: [ aTable selectedItems inspect ] ];
				  addItem: [ :anItem | 
					  anItem
						  name: 'Move to angular';
						  description: 'Migrate UI As new Component';
						  action: [ owner fullMigrateAll: aTable selectedItems ] ];
								 addItem: [ :anItem | 
					  anItem
						  name: 'Casino Model viewer';
						  shortcut: $i meta;
						  description: 'Inspect';
						  action: [ owner inspectCasinoModelFor:aTable selectedItems  ] ];
				  addItem: [ :anItem | 
					  anItem
						  name: 'Selective Migration';
						  description: 'Migrate UI Selecting new Component';
						  action: [ owner selectiveMigrateAll: aTable selectedItems ] ] ]
]

{ #category : #buileder }
STZInspectorBuilder >> visitAccessMooseModel: aJinAccessMooseModel [

	| table |
	table := self newTable.
	table
		addColumn: ((SpCheckBoxTableColumn
				  title: ' '
				  evaluated: [ :class | owner components includes: class ])
				 onActivation: [ :class | owner components add: class ];
				 onDeactivation: [ :class | 
					 owner components remove: class ifAbsent: [  ] ];
				 width: 20;
				 yourself);
		addColumn:
			((SpImageTableColumn
				  title: 'Icon'
				  evaluated: [ :e | self iconFor: e ])
				 width: 50;
				 yourself);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		activateOnDoubleClick;
		beMultipleSelection;
		contextMenu: (self tableMenuProject: table);
		beResizable.

	table items: aJinAccessMooseModel entities .
	inspector := table
]

{ #category : #'visit angular' }
STZInspectorBuilder >> visitAngularComponent: aJinAngularComponent [ 

	inspector := self createIconNameTable.
	inspector items: { aJinAngularComponent template . aJinAngularComponent behavior  } .
	
]

{ #category : #visiting }
STZInspectorBuilder >> visitAngularComponentBehavior: aJinAngularComponentBehaviour [ 
	
	inspector := self createIconNameTable.
	inspector 	addColumn: (SpStringTableColumn title: 'Type' evaluated: #type ).
	inspector items: 
		{aJinAngularComponentBehaviour superclass} , 
		aJinAngularComponentBehaviour interfaces,  
		aJinAngularComponentBehaviour properties, 
		aJinAngularComponentBehaviour methods 
]

{ #category : #'visit angular' }
STZInspectorBuilder >> visitAngularComponentTemplate: aJinAngularComponentTemplate [

	inspector := owner newTreeTable.
	inspector
		addColumn: (SpStringTableColumn title: 'Element' evaluated: [ : e |( e respondsTo:#name )ifTrue: [e name ] ifFalse:[ e class name,'[', e hash asString , ']' ]  ] );
		roots: { aJinAngularComponentTemplate ast };
		children: [ :anElement | 
			anElement hasChildren
				ifTrue: [ anElement nodes ]
				ifFalse: [ {  } ] ];
		yourself
]

{ #category : #'visit angular' }
STZInspectorBuilder >> visitAngularModule: aJinAngularModule [

	inspector := self createIconNameTable.
	inspector items:
		aJinAngularModule modules , aJinAngularModule components
]

{ #category : #'visit angular' }
STZInspectorBuilder >> visitAngularProject: aJinAngularProject [

	inspector := self createIconNameTable.
	inspector items: aJinAngularProject modules
]

{ #category : #visiting }
STZInspectorBuilder >> visitAngularProtoClass: anAngularProtoClass [
	self visitAngularComponentBehavior: anAngularProtoClass 
]

{ #category : #visiting }
STZInspectorBuilder >> visitAngularProtoComponent: aJinAngularProtoComponent [

	self visitAngularComponent: aJinAngularProtoComponent
]

{ #category : #visiting }
STZInspectorBuilder >> visitAngularProtoComponentBehavior: aJinAngularProtoComponentBehavior [ 
	^ self visitAngularComponentBehavior: aJinAngularProtoComponentBehavior
]

{ #category : #visiting }
STZInspectorBuilder >> visitAngularProtoComponentTemplate: aJinAngularProtoComponentTemplate [ 
	self visitAngularComponentTemplate: aJinAngularProtoComponentTemplate
]

{ #category : #'visit angular' }
STZInspectorBuilder >> visitAngularScheme: aJinAngularScheme [

	aJinAngularScheme defaultProject acceptVisitor: self
]

{ #category : #visiting }
STZInspectorBuilder >> visitCustomControl: aJinControlGeneric [ 

]

{ #category : #'as yet unclassified' }
STZInspectorBuilder >> visitForm: aForm [

	| table |
	table := self newTable.
	table
		addColumn:
			((SpImageTableColumn
				  title: 'Icon'
				  evaluated: [ :e | self iconFor: e ])
				 width: 50;
				 yourself);
		addColumn:
		(SpStringTableColumn title: 'Type' evaluated: [ :e | e class name copyReplaceAll:'Jin' with:'']);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		activateOnDoubleClick;
		beMultipleSelection;
		contextMenu: (self tableMenuForms: table);
		beResizable.
	table items: aForm controls.
	inspector := table
]

{ #category : #'as yet unclassified' }
STZInspectorBuilder >> visitFormControl: aControl [ 
	
]

{ #category : #'visit-first-objects' }
STZInspectorBuilder >> visitMacro: aJinMacro [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
STZInspectorBuilder >> visitModule: aJinModule [


]

{ #category : #'as yet unclassified' }
STZInspectorBuilder >> visitQuery: aQuery [ 


	| table |
	table := self newTable.
	table
		addColumn:
			((SpImageTableColumn
				  title: 'Icon'
				  evaluated: [ :e | self iconFor: e ])
				 width: 50;
				 yourself);
		addColumn:
		(SpStringTableColumn title: 'Type' evaluated: [ :e | e typeName ]);
		addColumn: (SpStringTableColumn title: 'Table' evaluated: #sourceTableName);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		activateOnDoubleClick;
		beMultipleSelection;
		contextMenu: (self tableMenuForQuery: table);
		beResizable.
	table items: aQuery fields.
	inspector := table


]

{ #category : #'as yet unclassified' }
STZInspectorBuilder >> visitReport: aReport [
	self visitForm: aReport
]

{ #category : #'as yet unclassified' }
STZInspectorBuilder >> visitTable: aJinTable [

	| table |
	table := self newTable.
	table
		addColumn:
			((SpImageTableColumn
				  title: 'Icon'
				  evaluated: [ :e | self iconFor: e ])
				 width: 50;
				 yourself);
		addColumn:
		(SpStringTableColumn title: 'Type' evaluated: [ :e | e typeName ]);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		activateOnDoubleClick;
		beMultipleSelection;
		contextMenu: (self tableMenuForTable: table);
		beResizable.
	table items: aJinTable fields.
	inspector := table
]

{ #category : #visiting }
STZInspectorBuilder >> visitTypescriptMethod: aJinTypescriptMethod [ 
	
	inspector := owner newText. 
	inspector text: aJinTypescriptMethod sourceCode 
	
]
