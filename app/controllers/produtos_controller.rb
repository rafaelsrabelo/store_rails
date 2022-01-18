class ProdutosController < ApplicationController
  layout 'application'
  before_action :set_produto, only: [:destroy, :edit, :update]

  def index 
    @produtos = Produto.order(quantidade: :asc)
    @produto_do_dia = Produto.order(:preco).limit 1
    @produto_acabando = Produto.order(quantidade: :asc).limit 2
  end

  def new
    @produto = Produto.new
    @departamentos = Departamento.all
  end

  def edit
    renderiza :edit
  end

  def update
    id = params[:id]
    @produto = Produto.find(id)
    valores = params.require(:produto).permit(:nome, :descricao, :preco, :quantidade, :departamento_id)
    if @produto.update valores
      flash[:notice] = "Produto atualizado com sucesso!"
      redirect_to root_url
    else
      @departamentos = Departamento.all
      render :edit
    end
  end

  def create
    @produto = Produto.new produto_params
    if @produto.save
      flash[:notice] = "Produto salvo com sucesso!"
      redirect_to root_path
    else id = params[:id]
      renderiza :new
    end
  end

  def destroy
    @produto.destroy
    redirect_to root_path, notice:"Produto excluído"
  end

  def busca
    @nome = params[:nome]
    @produtos = Produto.where "nome like ?", "%#{@nome}%"
  end

  private

  def set_produto
    @produto = Produto.find(params[:id])
  end

  def produto_params 
    params.require(:produto).permit(:nome, :descricao, :preco, :quantidade, :departamento_id)
  end

  def renderiza(view)
    @departamentos = Departamento.all
    render view
  end
end
