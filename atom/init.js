'use babel';

atom.commands.add('atom-text-editor', 'custom:extract-const', () => {
  const editor = atom.workspace.getActiveTextEditor();
  const selectedText = editor.getSelectedText();
	editor.insertText(`extractedConst`);
  newLineAbove(editor);
  editor.insertText(`const extractedConst = ${selectedText};`);
	editor.moveToBeginningOfLine();
	editor.moveToBeginningOfNextWord();
	editor.selectToEndOfWord();
});

// extractedConst.commands.add('atom-text-editor', 'custom:alt-i', () => {
//   const editor = atom.workspace.getActiveTextEditor();
//   debugger;
// });

atom.commands.add('atom-text-editor', 'custom:alt-d', () => {
  const editor = atom.workspace.getActiveTextEditor();
  newLine(editor);
  editor.insertText(`debugger;`);
});

atom.commands.add('atom-text-editor', 'custom:alt-shift-d', () => {
  const editor = atom.workspace.getActiveTextEditor();
  newLineAbove(editor);
  editor.insertText(`debugger;`);
});

atom.commands.add('atom-text-editor', 'custom:alt-semicolon', () => {
  const editor = atom.workspace.getActiveTextEditor();
  editor.moveToEndOfLine();
  editor.insertText(';');
});

atom.commands.add('atom-text-editor', 'custom:alt-c', () => {
  const editor = atom.workspace.getActiveTextEditor();
  const selectedText = editor.getSelectedText();
  newLine(editor);
  editor.insertText(`console.log('${selectedText}: ', ${selectedText});`);
});

atom.commands.add('atom-text-editor', 'custom:alt-shift-c', () => {
  const editor = atom.workspace.getActiveTextEditor();
  const selectedText = editor.getSelectedText();
  newLineAbove(editor);
  editor.insertText(`console.log('${selectedText}: ', ${selectedText});`);
});

atom.commands.add('atom-text-editor', 'custom:alt-o', () => {
  const editor = atom.workspace.getActiveTextEditor();
  newLine(editor);
});

atom.commands.add('atom-text-editor', 'custom:alt-shift-o', () => {
  const editor = atom.workspace.getActiveTextEditor();
  newLineAbove(editor);
});

function newLine(editor) {
  editor.moveToEndOfLine();
  editor.insertNewline();
}

function newLineAbove(editor) {
  editor.moveToBeginningOfLine();
  editor.insertNewlineAbove();
}

atom.commands.add('atom-text-editor', 'altup:alt-up', () => {
  const editor = atom.workspace.getActiveTextEditor();
  const buffer = editor.getBuffer();
  const row = editor.getCursorScreenPosition().row;

  editor.setCursorBufferPosition([previousBlockRow(buffer, row), 0]);
  editor.moveToFirstCharacterOfLine();
});

atom.commands.add('atom-text-editor', 'altup:alt-shift-up', () => {
  const editor = atom.workspace.getActiveTextEditor();
  const buffer = editor.getBuffer();
  const row = editor.getCursorScreenPosition().row;

  editor.selectToBufferPosition([previousBlockRow(buffer, row), 0]);
});

atom.commands.add('atom-text-editor', 'altup:alt-down', () => {
  const editor = atom.workspace.getActiveTextEditor();
  const buffer = editor.getBuffer();
  const row = editor.getCursorScreenPosition().row;

  editor.setCursorBufferPosition([nextBlockRow(buffer, row), 0]);
  editor.moveToFirstCharacterOfLine();
});

atom.commands.add('atom-text-editor', 'altup:alt-shift-down', () => {
  const editor = atom.workspace.getActiveTextEditor();
  const buffer = editor.getBuffer();
  const row = editor.getCursorScreenPosition().row;

  editor.selectToBufferPosition([nextBlockRow(buffer, row), 0]);
});

function previousBlockRow(buffer, row) {
  if (row <= 0) {
    return 0;
  }

  for (let i = row - 1; --i; i >= 0) {
    if (buffer.lines[i] === "" && buffer.lines[i + 1] !== "") {
      return i + 1;
    }
  }

  return 0;
}

function nextBlockRow(buffer, row) {
  if (row >= buffer.lines.length - 1) {
    return buffer.lines.length - 1;
  }

  for (let i = row; ++i; i < buffer.lines.length) {
    if (buffer.lines[i] === "") {
      if (buffer.lines[i + 1] === "") {
        continue;
      } else {
        return i + 1;
      }
    }
  }

  return buffer.lines.length - 1;
}
