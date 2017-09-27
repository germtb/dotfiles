'use babel'

const workspaceView = atom.views.getView(atom.workspace)
workspaceView.classList.add('loading')

atom.packages.onDidActivateInitialPackages(() => {
	const workspaceView = atom.views.getView(atom.workspace)
	atom.commands.dispatch(workspaceView, 'tree-view:toggle')
	workspaceView.classList.remove('loading')
})

atom.commands.add('atom-text-editor', 'textract:console-down', () => {
	const editor = atom.workspace.getActiveTextEditor()
	const selectedText = editor.getSelectedText()
	if (selectedText === '') {
		return
	}

	const checkpoint = editor.createCheckpoint()
	editor.insertNewlineBelow()
	editor.insertText(`console.log('${selectedText}: ', ${selectedText});`)
	editor.groupChangesSinceCheckpoint(checkpoint)
})

atom.commands.add('atom-text-editor', 'textract:console-up', () => {
	const editor = atom.workspace.getActiveTextEditor()
	const selectedText = editor.getSelectedText()
	if (selectedText === '') {
		return
	}

	const checkpoint = editor.createCheckpoint()
	editor.insertNewlineAbove()
	editor.insertText(`console.log('${selectedText}: ', ${selectedText});`)
	editor.groupChangesSinceCheckpoint(checkpoint)
})

atom.commands.add('atom-text-editor', 'textract:debugger-down', () => {
	const editor = atom.workspace.getActiveTextEditor()
	const checkpoint = editor.createCheckpoint()
	editor.insertNewlineBelow()
	editor.insertText(`debugger;`)
	editor.groupChangesSinceCheckpoint(checkpoint)
})

atom.commands.add('atom-text-editor', 'textract:debugger-up', () => {
	const editor = atom.workspace.getActiveTextEditor()
	const checkpoint = editor.createCheckpoint()
	editor.insertNewlineAbove()
	editor.insertText(`debugger;`)
	editor.groupChangesSinceCheckpoint(checkpoint)
})
