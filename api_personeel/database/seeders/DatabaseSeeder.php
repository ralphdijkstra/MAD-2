<?php

namespace Database\Seeders;

use App\Models\Functie;
use App\Models\Werknemer;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Voeg test functies toe en bewaar deze in variabele zodat je er bij de
        // testwerknemers aan kunt verwijzen.
        $softwareEngineer = Functie::create(['naam' => 'software engineer',]);
        $softwareArchitect = Functie::create(['naam' => 'software architect',]);
        $tester = Functie::create(['naam' => 'tester',]);
        Functie::create(['naam' => 'sales',]);
        $manager = Functie::create(['naam' => 'manager',]);
        $fieldEngineer = Functie::create(['naam' => 'field engineer',]);

        // Voeg test werknemers toe. Maak gebruik van de testfuncties die je hiervoor in
        // variabelen hebt bewaard. NB: De testwerknemers heb je hier niet meer nodig, dus
        // je hoeft ze niet in een variabele te bewaren.
        $jan = Werknemer::create([
            'naam' => 'Jan',
            'functie_id' => $softwareEngineer->id,
            'telefoon' => '0631874312', 'email' => 'jan@summa.nl', 'sinds' => '2002-11-01'
        ]);

        Werknemer::create([
            'naam' => 'Erdinc',
            'functie_id' => $softwareEngineer->id,
            'telefoon' => '0634981234', 'email' => 'erdinc@summa.nl', 'sinds' => '1989-11-01'
        ]);

        Werknemer::create([
            'naam' => 'Carla',
            'functie_id' => $manager->id,
            'telefoon' => '0634120975', 'email' => 'carla@summa.nl', 'sinds' => '1993-05-01'
        ]);

        Werknemer::create([
            'naam' => 'Ellen',
            'functie_id' => $softwareEngineer->id,
            'telefoon' => '0631451228', 'email' => 'elly@summa.nl', 'sinds' => '1995-08-15'
        ]);

        Werknemer::create([
            'naam' => 'Vijay',
            'functie_id' => $softwareArchitect->id,
            'telefoon' => '0631784466', 'email' => 'vijay@summa.nl', 'sinds' => '1997-08-01'
        ]);

        Werknemer::create([
            'naam' => 'Piet',
            'functie_id' => $fieldEngineer->id,
            'telefoon' => '0631552341', 'email' => 'piet@summa.nl', 'sinds' => '1999-07-01'
        ]);

        Werknemer::create([
            'naam' => 'Juma',
            'functie_id' => $tester->id,
            'telefoon' => '0631224550', 'email' => 'juma@summa.nl', 'sinds' => '2000-09-01'
        ]);
    }
}
