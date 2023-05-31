<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('werknemers', function (Blueprint $table) {
            $table->tinyInteger('id')->autoIncrement();
            $table->string('naam', 50)->nullable(false);
            $table->tinyInteger('functie_id');
            $table->string('telefoon', 20)->nullable(true);
            $table->string('email', 50)->nullable(true);
            $table->date('sinds')->nullable(true);

            $table->foreign('functie_id')->references('id')->on('functies')->restrictOnDelete();
        });
    }

    public function down()
    {
        Schema::dropIfExists('werknemers');
    }
};
