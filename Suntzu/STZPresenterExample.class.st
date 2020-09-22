Class {
	#name : #STZPresenterExample,
	#superclass : #SpPresenter,
	#category : #Suntzu
}

{ #category : #initialization }
STZPresenterExample >> initializePresenter [

	layout := SpBoxLayout newVertical. 
	1 to: 100 do: [  : i  | layout add:(self newButton label: i asString ) ].
	
]
