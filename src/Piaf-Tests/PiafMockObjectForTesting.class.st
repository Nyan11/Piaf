Class {
	#name : 'PiafMockObjectForTesting',
	#superclass : 'Object',
	#category : 'Piaf-Tests',
	#package : 'Piaf-Tests'
}

{ #category : 'mock' }
PiafMockObjectForTesting >> annotedMethod [

	self piaf: PiafRepositoryForTesting piafForTesting.
	self piaf: PiafRepositoryForTesting piafForTesting
]

{ #category : 'mock' }
PiafMockObjectForTesting >> anotherAnnotedMethod [

	self piaf: PiafRepositoryForTesting piafForTesting.
	self piaf: PiafRepositoryForTesting piafForTesting
]
