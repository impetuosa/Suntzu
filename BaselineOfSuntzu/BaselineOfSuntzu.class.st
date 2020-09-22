Class {
	#name : #BaselineOfSuntzu,
	#superclass : #BaselineOf,
	#category : #BaselineOfSuntzu
}

{ #category : #baselines }
BaselineOfSuntzu >> baseline: spec [

	<baseline>
	spec
		baseline: 'Moxing'
		with: [ spec repository: 'github://impetuosa/Moxing' ].
	spec baseline: 'Jindao' with: [ 
		spec loads: 'full';
			  repository: 'github://impetuosa/Jindao' ].
	spec package: 'Suntzu' with: [ spec requires: #( Moxing Jindao ) ].
	spec group: 'default' with: #( Suntzu )
]
