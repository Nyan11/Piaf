Class {
	#name : 'PiafBrowser',
	#superclass : 'SpPresenter',
	#instVars : [
		'repositoryList',
		'piafList',
		'classList',
		'methodList',
		'piafDefinitionCode',
		'methodCode',
		'selectedPiaf'
	],
	#category : 'Piaf-Browser',
	#package : 'Piaf-Browser'
}

{ #category : 'examples' }
PiafBrowser class >> open [

	<example>
	| app presenter |
	app := SpApplication new.
	presenter := self newApplication: app.
	presenter open
]

{ #category : 'initialization' }
PiafBrowser >> connectPresenters [

	repositoryList
		transmitTo: piafList
		transform: [ :aCollectionOfClasses |
				aCollectionOfClasses
					ifNotEmpty: [ aCollectionOfClasses flatCollect: #allPiafs ]
					ifEmpty: [ Array empty ] ].

	piafList transmitTo: classList transform: [ :aCollectionOfPiafs |
			self selectedPiaf: aCollectionOfPiafs.
			aCollectionOfPiafs flatCollect: #inCodeClasses ].
	piafList
		transmitTo: piafDefinitionCode
		transform: [ :aCollectionOfPiafs |
				aCollectionOfPiafs size
					caseOf: {
							(0 -> [ 'No Piaf selected.' ]).
							(1 -> [ aCollectionOfPiafs first repositoryMethod sourceCode ]) }
					otherwise: 'Multiple Piafs selected.' ].

	classList
		transmitTo: methodList
		transform: [ :aCollectionOfClasses |
				aCollectionOfClasses
					ifNotEmpty: [
							self selectedPiaf flatCollect: [ :piaf |
									aCollectionOfClasses flatCollect: [ :class |
										piaf inCodeMethodsForClass: class ] ] ]
					ifEmpty: [ Array empty ] ].
	methodList
		transmitTo: methodCode
		transform: [ :aCollectionOfMethod |
				aCollectionOfMethod size
					caseOf: {
							(0 -> [ 'No method selected.' ]).
							(1 -> [ aCollectionOfMethod first sourceCode ]) }
					otherwise: 'Multiple methods selected.' ].

	self intializeRepositoryItems
]

{ #category : 'initialization' }
PiafBrowser >> defaultLayout [

	| listsLayout codeLayout |
	listsLayout := SpPanedLayout newLeftToRight
		               positionOfSlider: 1 / 2;
		               add: #repositoryList;
		               add: #piafList;
		               yourself.
	listsLayout := SpPanedLayout newLeftToRight
		               positionOfSlider: 2 / 3;
		               add: listsLayout;
		               add: #classList;
		               yourself.
	listsLayout := SpPanedLayout newLeftToRight
		               positionOfSlider: 3 / 4;
		               add: listsLayout;
		               add: #methodList;
		               yourself.

	codeLayout := SpPanedLayout newLeftToRight
		              positionOfSlider: 1 / 2;
		              add: #piafDefinitionCode;
		              add: #methodCode;
		              yourself.

	^ SpPanedLayout newTopToBottom
		  positionOfSlider: 1 / 2;
		  add: listsLayout;
		  add: codeLayout;
		  yourself
]

{ #category : 'initialization' }
PiafBrowser >> initializePresenters [

	repositoryList := self newList
		                  beMultipleSelection;
		                  display: [ :each | each name ];
		                  displayIcon: [ :each | self iconNamed: #package ];
		                  yourself.
	piafList := self newList
		            beMultipleSelection;
		            display: [ :each | each repositorySelector ];
		            display: [ :each | each repositorySelector ];
		            displayIcon: [ :each |
				            each inCodeMethods
					            ifEmpty: [ self iconNamed: #smallError ]
					            ifNotEmpty: [ self iconNamed: #smallOk ] ];
		            yourself.
	classList := self newList
		             beMultipleSelection;
		             display: [ :each | each name ];
		             displayIcon: [ :each |
			             self iconNamed: each systemIconName ];
		             yourself.
	methodList := self newList
		              beMultipleSelection;
		              display: [ :each | each selector ];
		              yourself.
	piafDefinitionCode := self newCode beForScripting.
	methodCode := self newCode
]

{ #category : 'initialization' }
PiafBrowser >> intializeRepositoryItems [

	| repositories |
	repositories := ((Pragma allNamed: #piaf) collect: [ :p | p method methodClass instanceSide]) asOrderedCollection removeDuplicates.
	repositoryList items: repositories
]

{ #category : 'accessing' }
PiafBrowser >> selectedPiaf [

	^ selectedPiaf
]

{ #category : 'accessing' }
PiafBrowser >> selectedPiaf: anObject [

	selectedPiaf := anObject
]
