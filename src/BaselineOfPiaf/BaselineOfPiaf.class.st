Class {
	#name : 'BaselineOfPiaf',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPiaf',
	#package : 'BaselineOfPiaf'
}

{ #category : 'baselines' }
BaselineOfPiaf >> baseline: spec [
	"Common baseline for all Pharo versions"

	<baseline>
	spec for: #common do: [ self baselineForCommon: spec ]
]

{ #category : 'baselines' }
BaselineOfPiaf >> baselineForCommon: spec [
	"Packages"

	<baseline>
	spec package: 'Piaf'.
	spec package: 'Piaf-Browser' with: [ spec requires: #( 'Piaf' ) ].
	spec package: 'Piaf-Tests' with: [ spec requires: #( 'Piaf' ) ].

	"Groups"
	spec group: 'default' with: #( 'Piaf' 'Piaf-Browser' 'Piaf-Tests' )
]
