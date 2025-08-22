Extension { #name : 'Object' }

{ #category : '*Piaf' }
Object class >> allPiafs [

	^ self class methods
		  select: [ :m | m hasPragmaNamed: #piaf ]
		  thenCollect: [ :m | (m valueWithReceiver: self) ]
]

{ #category : '*Piaf' }
Object class >> allPiafsInCode [

	^ self allPiafs select: [ :piaf | piaf inCodeMethods isNotEmpty ]
]

{ #category : '*Piaf' }
Object class >> allPiafsNotInCode [

	^ self allPiafs select: [ :piaf | piaf inCodeMethods isEmpty ]
]

{ #category : '*Piaf' }
Object >> piaf: aPiaf [

	Piaf uniqueAnnouncer announce:
		(PiafAnnouncement piaf: aPiaf forReceiver: self)
]

{ #category : '*Piaf' }
Object >> piafMethods [

	<ignorePiaf>
	| possiblePiafMethods |
	possiblePiafMethods := SystemNavigation default
		                       allReferencesTo: #piaf:
		                       in: self class withAllSuperclasses.
	^ possiblePiafMethods reject: [ :method |
		  method hasPragmaNamed: #ignorePiaf ]
]

{ #category : '*Piaf' }
Object >> piafMethodsFor: aClass [

	^ self piafMethods select: [ :m | m variableNodes anySatisfy: [ :var | var name = aClass instanceSide name asString ]].

]
