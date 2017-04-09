package models

import (
	"testing"

	"github.com/FoxComm/gizmo/testutils"
)

func TestFindLatest(t *testing.T) {
	assert := testutils.NewAssert(t)

	db := testutils.InitDB(t)
	defer db.Close()

	context := createObjectContext(t, db)
	fullObject := createFullObject(t, db, context)
	head := createObjectHead(t, db, context, fullObject.Commit)

	latest, err := fullObject.FindLatest(db, head.ID, head.ContextID)
	if err != nil {
		t.Error(err)
	}

	assert.Equal(fullObject.Form.ID, latest.Form.ID)
	assert.Equal(fullObject.Shadow.ID, latest.Shadow.ID)
	assert.Equal(fullObject.Commit.ID, latest.Commit.ID)
}
