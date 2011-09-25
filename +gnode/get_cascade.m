function o = get_cascade(session, id)

  top_block = gnode.get(session, 'block_25');
  segments = gnode.get(session, cell(top_block.segment).');

  top_block.segment = segments;

  o = top_block;

end
