Class {
	#name : 'PiafAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'piaf',
		'receiver'
	],
	#category : 'Piaf',
	#package : 'Piaf'
}

{ #category : 'as yet unclassified' }
PiafAnnouncement class >> piaf: aPiaf forReceiver: anObject [

	<ignorePiaf>
	^ self new
		  piaf: aPiaf;
		  receiver: anObject;
		  yourself
]

{ #category : 'accessing' }
PiafAnnouncement >> piaf [

	^ piaf
]

{ #category : 'accessing' }
PiafAnnouncement >> piaf: aPiaf [

	piaf := aPiaf
]

{ #category : 'accessing' }
PiafAnnouncement >> receiver [

	^ receiver
]

{ #category : 'accessing' }
PiafAnnouncement >> receiver: anObject [

	receiver := anObject
]
