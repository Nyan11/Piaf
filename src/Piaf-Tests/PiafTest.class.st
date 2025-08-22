Class {
	#name : 'PiafTest',
	#superclass : 'TestCase',
	#category : 'Piaf-Tests',
	#package : 'Piaf-Tests'
}

{ #category : 'tests' }
PiafTest >> tearDown [

	super tearDown.
	Piaf uniqueAnnouncer unsubscribe: self
]

{ #category : 'tests' }
PiafTest >> testAllPiafs [

	<ignorePiafTest>
	| piafs |
	piafs := PiafRepositoryForTesting allPiafs.

	self assert: piafs size equals: 2
]

{ #category : 'tests' }
PiafTest >> testAllPiafsInCode [

	<ignorePiafTest>
	| piafs |
	piafs := PiafRepositoryForTesting allPiafsInCode.

	self assert: piafs size equals: 1.
	self assert: (piafs anySatisfy: [ :p |
			 p repositoryMethod selector = #piafForTesting ]).
	self assert: (piafs anySatisfy: [ :p |
			 p inCodeMethods anySatisfy: [ :m | m selector = #annotedMethod ] ])
]

{ #category : 'tests' }
PiafTest >> testAllPiafsNotInCode [

	<ignorePiafTest>
	| piafs |
	piafs := PiafRepositoryForTesting allPiafsNotInCode.

	self assert: piafs size equals: 1.
	self assert: (piafs anySatisfy: [ :p |
			 p repositoryMethod selector = #piafNotInstalledForTesting ])
]

{ #category : 'tests' }
PiafTest >> testPiafMethods [

	| annotedMethods |
	annotedMethods := PiafMockObjectForTesting new piafMethods.

	self assert: annotedMethods size equals: 2.
	self assert:
		(annotedMethods anySatisfy: [ :m | m selector = #annotedMethod ])
]

{ #category : 'tests' }
PiafTest >> testPiafMethodsFor [

	| annotedMethods |
	annotedMethods := PiafMockObjectForTesting new piafMethodsFor:
		                  PiafRepositoryForTesting.

	self assert: annotedMethods size equals: 2.
	self assert:
		(annotedMethods anySatisfy: [ :m | m selector = #annotedMethod ])
]

{ #category : 'tests' }
PiafTest >> testPiafValue [

	| counter |
	counter := 0.
	Piaf uniqueAnnouncer
		when: PiafAnnouncement
		do: [ :evt |
				evt piaf repositoryClass = PiafRepositoryForTesting ifTrue: [
					counter := counter + 1 ] ]
		for: self.
	PiafMockObjectForTesting new annotedMethod.
	self assert: counter equals: 2
]
