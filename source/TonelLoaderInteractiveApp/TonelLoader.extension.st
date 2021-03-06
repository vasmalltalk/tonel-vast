Extension {
	#name : 'TonelLoader'
}

{ #category : '*TonelLoaderInteractiveApp',
 #vaCategories : ['strategies-convenience'] }
TonelLoader >> beInteractive [
	self useInteractivePrerequisitesSelection.
	self useInteractiveBaseEditionSelection.
	self useInteractiveVersioning
]

{ #category : '*TonelLoaderInteractiveApp',
 #vaCategories : ['strategies-convenience'] }
TonelLoader >> useInteractiveBaseEditionSelection [
	self 
		baseEditionStrategy: (TonelLoaderInteractiveBaseEditionStrategy for: self)
]

{ #category : '*TonelLoaderInteractiveApp',
 #vaCategories : ['strategies-convenience'] }
TonelLoader >> useInteractivePrerequisitesSelection [
	self 
		prerequisitesStrategy: (TonelLoaderInteractivePrereqStrategy for: self)
]

{ #category : '*TonelLoaderInteractiveApp',
 #vaCategories : ['strategies-convenience'] }
TonelLoader >> useInteractiveVersioning [
	self versionStrategy: (TonelLoaderInteractiveVersionStrategy for: self)
]
