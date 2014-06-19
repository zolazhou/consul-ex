defmodule Consul.Handler.Behaviour do
  use Behaviour

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)

      def consul_index(%{headers: %{"X-Consul-Index" => index}}), do: index
      def consul_index(_), do: nil

      def handle(%{status_code: 200} = response) do
        {:ok, response}
      end
      def handle(response) do
        {:error, response}
      end

      defoverridable [handle: 1]
    end
  end

  defcallback handle(result :: any)
end