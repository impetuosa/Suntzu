Class {
	#name : #STZMigrationManager,
	#superclass : #Object,
	#instVars : [
		'itemsToMigrate',
		'destination',
		'casinoModel',
		'angularModel'
	],
	#category : #Suntzu
}

{ #category : #'as yet unclassified' }
STZMigrationManager >> calculateComponents [

	casinoModel := self loadCasinoModel. 
	angularModel := MOCasinoToAngularModel
		                loadFrom: casinoModel
		                into: destination
]

{ #category : #accessing }
STZMigrationManager >> destination: aJinAngularModule [ 
	destination := aJinAngularModule
]

{ #category : #'as yet unclassified' }
STZMigrationManager >> loadCasinoModel [
	^ MOCasinoPartialModelCreator
		createModelOnSpecific: itemsToMigrate
		inTheContextOf: destination
		named: 'MigrationProcess'
]

{ #category : #'as yet unclassified' }
STZMigrationManager >> registerElements: aCollection [ 
	itemsToMigrate := aCollection  
]
