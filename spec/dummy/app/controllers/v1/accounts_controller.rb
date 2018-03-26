module V1
  class AccountsController < V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "accounts",
    )
  end
end
