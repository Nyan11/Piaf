Class {
	#name : 'PiafBlocExample',
	#superclass : 'Object',
	#category : 'Piaf-Bloc',
	#package : 'Piaf-Bloc'
}

{ #category : 'examples' }
PiafBlocExample class >> example [

	| root instrumentation |
	instrumentation := PiafBlocInstrumentation new.

	instrumentation startInstrumentation.

	root := self makeNewBlElements.

	instrumentation stopInstrumentation
]

{ #category : 'examples' }
PiafBlocExample class >> makeNewBlElements [

	| root red green blue |
	red := BlElement new
		       background: Color red;
		       piaf: PiafBlocExample oneOfTheElementsIsRed;
		       yourself.
	green := BlElement new
		         background: Color green;
		         piaf: PiafBlocExample oneOfTheElementsIsGreen;
		         yourself.
	blue := BlElement new
		        background: Color blue;
		        piaf: PiafBlocExample oneOfTheElementsIsBlue;
		        yourself.

	root := BlElement new
		        addChildren: {
				        red.
				        green.
				        blue };
		        piaf: PiafBlocExample theExampleNeed3Elements.
	^ root
]

{ #category : 'as yet unclassified' }
PiafBlocExample class >> oneOfTheElementsIsBlue [
	"test"

	<piaf>
	^ Piaf new
]

{ #category : 'as yet unclassified' }
PiafBlocExample class >> oneOfTheElementsIsGreen [
	"test"

	<piaf>
	^ Piaf new
]

{ #category : 'as yet unclassified' }
PiafBlocExample class >> oneOfTheElementsIsRed [
	"test"

	<piaf>
	^ Piaf new
]

{ #category : 'as yet unclassified' }
PiafBlocExample class >> theExampleNeed3Elements [
	"test"

	<piaf>
	^ Piaf new
]
