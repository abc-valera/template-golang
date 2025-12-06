package echo

import (
	"context"
	"fmt"

	"github.com/danielgtaylor/huma/v2"
)

func ApplyRoutes(api huma.API) {
	huma.Get(api, "/echo/{message}", echoHandler)
}

type EchoInput struct {
	Message string `path:"message" maxLength:"30" example:"hi-there" doc:"Message to echo"`
}

type EchoOutput struct {
	Body struct {
		Greeting string `json:"message" example:"template-golang: hi-there" doc:"Prepended echo message"`
	}
}

func echoHandler(ctx context.Context, input *EchoInput) (*EchoOutput, error) {
	resp := &EchoOutput{}
	resp.Body.Greeting = fmt.Sprintf("template-golang: %s", input.Message)
	return resp, nil
}
