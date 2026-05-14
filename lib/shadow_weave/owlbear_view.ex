defmodule ShadowWeave.OwlbearView do
  require EEx

  @templates_path Path.expand("../../templates", __DIR__)

  EEx.function_from_file(:def, :index, Path.join(@templates_path, "index.eex"), [:owlbears])
  EEx.function_from_file(:def, :show, Path.join(@templates_path, "show.eex"), [:owlbear])
end
