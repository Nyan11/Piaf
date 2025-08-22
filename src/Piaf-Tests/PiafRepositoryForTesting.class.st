Class {
	#name : 'PiafRepositoryForTesting',
	#superclass : 'Object',
	#category : 'Piaf-Tests',
	#package : 'Piaf-Tests'
}

{ #category : 'as yet unclassified' }
PiafRepositoryForTesting class >> piafForTesting [

	<piaf>
	^ Piaf new.
]

{ #category : 'as yet unclassified' }
PiafRepositoryForTesting class >> piafNotInstalledForTesting [

	<piaf>
	^ Piaf new
]
