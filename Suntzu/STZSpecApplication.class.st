Class {
	#name : #STZSpecApplication,
	#superclass : #SpApplication,
	#classVars : [
		'Current'
	],
	#category : #Suntzu
}

{ #category : #'instance creation' }
STZSpecApplication class >> current [ 
	
	^ Current ifNil: [ Current := self new ]
]

{ #category : #'class initialization' }
STZSpecApplication class >> initialize [ 

	SessionManager default registerToolClassNamed: self name
]

{ #category : #'system startup' }
STZSpecApplication class >> shutDown: quitting [

	Current ifNil: [ ^ self ].
	Current shutDown: quitting
]

{ #category : #'system startup' }
STZSpecApplication class >> startUp: resuming [

	Current ifNil: [ ^ self ].
	Current startUp: resuming
]

{ #category : #initialization }
STZSpecApplication >> initialize [

	super initialize.
	self resetConfiguration
]

{ #category : #initialization }
STZSpecApplication >> resetConfiguration [
	
	self flag: #TODO. "Replace this with a proper initialization mechanism (which is not
	implemented at the moment, and we need to choose the backend from it)"
	self class environment 
		at: #StPharoMorphicConfiguration
		ifPresent: [ :aClass | self useBackend: #Morphic with: aClass new ]
]

{ #category : #running }
STZSpecApplication >> run [ 

	Current ifNotNil: [ Current close ].
	super run. 
	Current := self
]

{ #category : #'system startup' }
STZSpecApplication >> shutDown: quitting [
]

{ #category : #'private running' }
STZSpecApplication >> start [

	
]

{ #category : #'system startup' }
STZSpecApplication >> startUp: resuming [
]

{ #category : #settings }
STZSpecApplication >> toolbarDisplayMode [

	^ StPharoSettings toolbarDisplayMode
]
