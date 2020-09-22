Class {
	#name : #STZTreeMapPresenter,
	#superclass : #STZPresenter,
	#instVars : [
		'treemap'
	],
	#category : #Suntzu
}

{ #category : #specs }
STZTreeMapPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		  add: #treemap;
		  yourself
]

{ #category : #initialization }
STZTreeMapPresenter >> initializePresenters [

	super initializePresenters.
	treemap := self instantiate: MiTreeMap. 
	treemap childrenBlock: [ :el | 
		((el usesFamixTrait: TEntityMetaLevelDependency) or: [ 
			 el respondsTo: #children ])
			ifTrue: [ el children ]
			ifFalse: [ {  } ] ]
]

{ #category : #initialization }
STZTreeMapPresenter >> model: aModel [

	treemap
		unHighlight;
		rootEntities: aModel rootsForTreeMap.
	treemap run
]
