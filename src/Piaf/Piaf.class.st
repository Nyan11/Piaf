"
Prototype Internal Annotation Flag

Use this package to add annotation flag inside the code of your prototype.
These flags can be used to trace requirement and follow their evolution.
"
Class {
	#name : 'Piaf',
	#superclass : 'Object',
	#instVars : [
		'inCodeMethods',
		'repositoryMethod'
	],
	#classVars : [
		'UniqueAnnouncer',
		'UniquePiafDictionary'
	],
	#category : 'Piaf',
	#package : 'Piaf'
}

{ #category : 'event handling' }
Piaf class >> handleMethodChange: aMethodChange [

	(aMethodChange method hasPragmaNamed: #piaf) ifFalse: [ ^ self ].
	UniquePiafDictionary removeKey: aMethodChange oldMethod ifAbsent: [ ^ self ]
]

{ #category : 'class initialization' }
Piaf class >> initialize [

	UniqueAnnouncer := Announcer new.
	UniquePiafDictionary := IdentityDictionary new.
	
	self registerSystemAnnouncements
]

{ #category : 'instance creation' }
Piaf class >> new [

	| repositoryMethod |
	"Ici on peut mettre en place un dictionnaire de Piaf avec en clé la méthode qui créé les piafs et valeur le piaf. De cette façon on évite d'instancier des millier d'objet identique."
	repositoryMethod := (thisContext sender method hasPragmaNamed: #piaf)
		                    ifTrue: [ thisContext sender method ].
	^ self uniquePiafDictionary at: repositoryMethod ifAbsentPut: [
			  | piaf |
			  piaf := super new.
			  repositoryMethod ifNotNil: [
				  piaf repositoryMethod: repositoryMethod ].
			  piaf ]
]

{ #category : 'class initialization' }
Piaf class >> registerSystemAnnouncements [

	self unregisterSystemAnnouncements.

	self codeChangeAnnouncer weak
		when: MethodModified
		send: #handleMethodChange:
		to: self
]

{ #category : 'as yet unclassified' }
Piaf class >> uniqueAnnouncer [

	^ UniqueAnnouncer
]

{ #category : 'as yet unclassified' }
Piaf class >> uniquePiafDictionary [

	^ UniquePiafDictionary
]

{ #category : 'class initialization' }
Piaf class >> unregisterSystemAnnouncements [

	self codeSupportAnnouncer unsubscribe: self.
	self codeChangeAnnouncer unsubscribe: self
]

{ #category : 'accessing' }
Piaf >> inCodeClasses [

	^ (inCodeMethods collect: [ :m | m methodClass ]) removeDuplicates 
]

{ #category : 'accessing' }
Piaf >> inCodeMethods [

	^ inCodeMethods
]

{ #category : 'accessing' }
Piaf >> inCodeMethodsForClass: aClass [

	^ inCodeMethods select: [ :m | m methodClass = aClass ]
]

{ #category : 'as yet unclassified' }
Piaf >> repositoryClass [

	^ self repositoryMethod methodClass instanceSide
]

{ #category : 'accessing' }
Piaf >> repositoryMethod [

	^ repositoryMethod
]

{ #category : 'accessing' }
Piaf >> repositoryMethod: anObject [

	| possiblePiafMethodsBySelector possiblePiafMethodsByClass possiblePiafMethods |
	self
		assert: repositoryMethod isNil
		description: 'The repository can only be set once.'.

	repositoryMethod := anObject.

	possiblePiafMethodsBySelector := SystemNavigation default
		                                 allSendersOf:
		                                 repositoryMethod selector.
	possiblePiafMethodsByClass := SystemNavigation default
		                              allGlobalRefsOn:
		                              repositoryMethod methodClass
			                              instanceSide name asString.
	possiblePiafMethods := possiblePiafMethodsBySelector intersection:
		                       possiblePiafMethodsByClass.
	inCodeMethods := possiblePiafMethods reject: [ :method |
		                 method hasPragmaNamed: #ignorePiafTest ]
]

{ #category : 'as yet unclassified' }
Piaf >> repositorySelector [

	^ self repositoryMethod selector
]
