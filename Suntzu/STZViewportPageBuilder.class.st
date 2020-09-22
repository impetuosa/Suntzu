Class {
	#name : #STZViewportPageBuilder,
	#superclass : #Object,
	#instVars : [
		'page',
		'owner'
	],
	#category : #Suntzu
}

{ #category : #'as yet unclassified' }
STZViewportPageBuilder >> buildPageFor: aJinAngularComponentBehaviour into: aSpNotebookPresenter [

	owner := aSpNotebookPresenter.
	aJinAngularComponentBehaviour acceptVisitor: self.
	page ifNotNil: [ 
		owner addPage: page.
		owner selectPage: page 
	]
]

{ #category : #visiting }
STZViewportPageBuilder >> newTextPageNamed: name withContent: content [
	| textPage | 
	textPage := owner newNotebookPage.
	textPage beCloseable .
	textPage title: name.
	textPage presenterProvider: [ owner newText text: content ].
	^ textPage
]

{ #category : #visiting }
STZViewportPageBuilder >> visitAccessMooseModel: aJinAccessMooseModel [ 

]

{ #category : #visiting }
STZViewportPageBuilder >> visitAngularComponent: aJinAngularComponent [

	
]

{ #category : #visiting }
STZViewportPageBuilder >> visitAngularComponentBehavior: aJinAngularComponentBehaviour [

	page := self
		        newTextPageNamed: aJinAngularComponentBehaviour name
		        withContent: aJinAngularComponentBehaviour sourceCode
]

{ #category : #visiting }
STZViewportPageBuilder >> visitAngularComponentTemplate: aJinAngularComponentTemplate [

	page := self
		        newTextPageNamed: aJinAngularComponentTemplate name
		        withContent: aJinAngularComponentTemplate sourceCode
]

{ #category : #visiting }
STZViewportPageBuilder >> visitAngularModule: aJinAngularModule [ 

]

{ #category : #visiting }
STZViewportPageBuilder >> visitAngularProtoComponent: aJinAngularProtoComponent [

	self visitAngularComponent: aJinAngularProtoComponent
]

{ #category : #visiting }
STZViewportPageBuilder >> visitAngularProtoComponentBehavior: aJinAngularProtoComponentBehavior [ 
	self visitAngularComponentBehavior: aJinAngularProtoComponentBehavior
]

{ #category : #visiting }
STZViewportPageBuilder >> visitAngularProtoComponentTemplate: aJinAngularProtoComponentTemplate [ 
	self visitAngularComponentTemplate: aJinAngularProtoComponentTemplate
]

{ #category : #visiting }
STZViewportPageBuilder >> visitAngularScheme: aJinAngularScheme [ 
	
]

{ #category : #visiting }
STZViewportPageBuilder >> visitCustomControl: aJinControlGeneric [ 

]

{ #category : #visiting }
STZViewportPageBuilder >> visitForm: aJinForm [

]

{ #category : #visiting }
STZViewportPageBuilder >> visitModule: aJinObject [


]

{ #category : #visiting }
STZViewportPageBuilder >> visitQuery: aJinObject [


]

{ #category : #visiting }
STZViewportPageBuilder >> visitReport: aJinForm [

]

{ #category : #visiting }
STZViewportPageBuilder >> visitTable: aJinObject [


]
