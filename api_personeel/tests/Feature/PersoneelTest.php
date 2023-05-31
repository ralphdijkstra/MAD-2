<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class PersoneelTest extends TestCase
{
    /**
     * Test dat api/werknemers/{id} werkt (GET)
     * @return void
     */
    public function test_werknemer_op_id()
    {
        Sanctum::actingAs(User::factory()->create(),['*']);

        $response = $this->get('api/werknemers/1');

        $response
            ->assertStatus(200)
            ->assertJsonPath('success', true)
            ->assertJsonPath('data.naam', 'Jan')
            ->assertJsonPath('data.email', 'jan@summa.nl');
    }

    /**
     * Test dat api/werknemers?naam={naam} (GET)
     * @return void
     */
    public function test_werknemer_op_naam()
    {
        Sanctum::actingAs(User::factory()->create(),['*']);

        $response = $this->get('api/werknemers?naam=J');
        $response
            ->assertStatus(200)
            ->assertJsonCount(3, 'data')
            ->assertJsonPath('data.0.naam', 'Jan')
            ->assertJsonPath('data.0.email', 'jan@summa.nl')
            ->assertJsonFragment(
                ['naam' => 'Vijay', 'email' => 'vijay@summa.nl',]
            );
    }

    /**
     * Test dat api/werknemers werkt, om werknemer toe te voegen (POST)
     * @return void
     */
    public function test_insert_werknemer()
    {
        Sanctum::actingAs(User::factory()->create(),['*']);

        $data = ['naam' => 'Karel', 'email' => 'karel@summa.nl', 'functie_id' => 1];
        $response = $this->json('POST', 'api/werknemers', $data);

        $this->assertDatabaseHas(
            'werknemers', ['naam' => 'Karel', 'email' => 'karel@summa.nl',]
        );

        $response
            ->assertStatus(201)
            ->assertJsonPath('data.naam', 'Karel')
            ->assertJsonPath('data.email', 'karel@summa.nl');
    }

    /**
     * Test dat api/werknemers werkt, om werknemer toe te voegen (POST)
     * @return void
     */
    public function test_delete_werknemer()
    {
        Sanctum::actingAs(User::factory()->create(),['*']);

        $response = $this->delete('api/werknemers/7');
        $response->assertStatus(202);
    }
}
