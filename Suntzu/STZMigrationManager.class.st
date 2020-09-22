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

	casinoModel := JinCasinoPartialModelCreator
		               createModelOnSpecific: itemsToMigrate
		               named: 'MigrationProcess'.
	angularModel := MOCasinoToAngularModel
		                loadFrom: casinoModel
		                into: destination
]

{ #category : #accessing }
STZMigrationManager >> destination: aJinAngularModule [ 
	destination := aJinAngularModule
]

{ #category : #'as yet unclassified' }
STZMigrationManager >> registerElements: aCollection [ 
	itemsToMigrate := aCollection  
]
