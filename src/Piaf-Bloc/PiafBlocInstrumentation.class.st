Class {
	#name : 'PiafBlocInstrumentation',
	#superclass : 'Object',
	#category : 'Piaf-Bloc',
	#package : 'Piaf-Bloc'
}

{ #category : 'instance creation' }
PiafBlocInstrumentation >> newPiafExecution: aPiafAnnouncement [

	(aPiafAnnouncement receiver isKindOf: BlElement) ifFalse: [ ^ self ].

	aPiafAnnouncement receiver userData
		at: #piafs
		ifPresent: [ :col | col add: aPiafAnnouncement piaf ]
		ifAbsentPut: [ Set with: aPiafAnnouncement piaf ]
]

{ #category : 'as yet unclassified' }
PiafBlocInstrumentation >> startInstrumentation [

	Piaf uniqueAnnouncer
		when: PiafAnnouncement
		send: #newPiafExecution:
		to: self
]

{ #category : 'as yet unclassified' }
PiafBlocInstrumentation >> stopInstrumentation [

	Piaf uniqueAnnouncer unsubscribe: self.
]
