<?php

namespace Repository;
interface BaseInterfaceRepository {

    public function get($collection = null);

    public function save($data);
}
