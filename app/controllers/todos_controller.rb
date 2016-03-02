class TodosController < ApplicationController
  expose(:todos) { Todo.all }
  expose(:todo) { Todo.find_by(id: params[:id]) || Todo.new(todo_params) }

  def create
    todo_actions(todo.save)
  end

  def destroy
    todo_actions(todo.update(checked: true))
  end

  private

  def todo_params
    params.require(:todo).permit!
  end

  def todo_actions(action)
    action ? (render partial: 'todo', locals: { todo: todo }) : (render json: todo.errors.to_json)
  end
end
