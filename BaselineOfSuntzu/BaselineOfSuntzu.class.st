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
	spec
		baseline: 'Jindao'
		with: [ spec repository: 'github://impetuosa/Jindao' ].
	spec
		baseline: 'CasinoGlue'
		with: [ spec repository: 'github://impetuosa/CasinoGlue' ].
	spec
		package: 'Suntzu'
		with: [ spec requires: #(Moxing Jindao CasinoGlue) ].
	spec group: 'default' with: #(Suntzu)
]
