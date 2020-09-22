Class {
	#name : #STZPresenter,
	#superclass : #StPresenter,
	#category : #Suntzu
}

{ #category : #private }
STZPresenter class >> currentApplication [

	^ STZSpecApplication current
]
